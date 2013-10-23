#import "DBSAdminCourseViewController.h"
#import "DBSScheduleService.h"
#import "DBSDatabaseService.h"
#import "DBSLecture.h"
#import "DBSAdminCourseFormViewController.h"
#import "DBSDayViewController.h"

@interface DBSAdminCourseViewController ()
{
    DBSScheduleService *schedule;
    DBSDatabaseService *database;
    NSMutableArray *courseLectures;
}

@end

@implementation DBSAdminCourseViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        UINavigationItem *item = [self navigationItem];
        [item setTitle:@"Lectures"];
        UIBarButtonItem *buttonAdd = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                      target:self action:@selector(addTemplate:)];
        [[self navigationItem] setRightBarButtonItem:buttonAdd];
        
        self.tableView.separatorColor = [UIColor clearColor];
        courseLectures = [[NSMutableArray alloc] init];
        database = [DBSDatabaseService database];
        NSArray *lecturesArray = [database getLectures];
        
        // Number of IDs
        int topID = 1;
        for (DBSLecture* lec in lecturesArray) {
            if([[lec courseID] intValue]>topID) {
                topID = [[lec courseID] intValue];
            }
        }
        // Set lecture ID list
        for (int i=0; i<=topID; i++) {
            for (DBSLecture* lecture in lecturesArray) {
                if (([[lecture courseID] intValue]==i)&&([[lecture version] intValue]==1)) {
                    NSString *keyID = [NSString stringWithFormat:@"%@", [lecture courseID]];
                    NSMutableArray *list = [[NSMutableArray alloc] init];
                    [list addObject:lecture];
                    NSDictionary *courseDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                keyID, @"ID", list, @"COURSE", nil];
                    [courseLectures addObject:courseDict];
                }
            }
        }
        // Fill lecture events
        for (DBSLecture* lecture in lecturesArray) {
            if ([[lecture version] intValue]!=1) {
                for (NSDictionary *dict in courseLectures) {
                    if ([[dict objectForKey:@"ID"] isEqualToString:[lecture courseID]]) {
                        [[dict objectForKey:@"COURSE"] addObject:lecture];
                    }
                }
            }
        }
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chalkboard.jpg"]];
    [[self tableView]setBackgroundView:imgView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self tableView] reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [courseLectures count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[courseLectures objectAtIndex:section] objectForKey:@"COURSE"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    DBSLecture *lecture = [[[courseLectures objectAtIndex:[indexPath section]] objectForKey:@"COURSE"] objectAtIndex:[indexPath row]];
    NSString *course = [NSString stringWithFormat:@"%@.%@  %@",[lecture courseID],[lecture version],[lecture course]];
    NSString *time = [NSString stringWithFormat:@"%@ - %@", [lecture startTime],[lecture stopTime]];
    [[cell textLabel] setText: course];
    [[cell detailTextLabel] setText:time];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]==0) {
        // EDIT TEMPLATE
        DBSAdminCourseFormViewController *editLecture = [[DBSAdminCourseFormViewController alloc] initEditTemplate];
        DBSLecture *lecture = [[[courseLectures objectAtIndex:[indexPath section]] objectForKey:@"COURSE"] objectAtIndex:[indexPath row]];
        [editLecture setLecture:lecture];
        // EXECUTION BLOCK FOR EVENT-CREATION
        [editLecture setAddBlock:^void(DBSLecture* lec){
            [[[courseLectures objectAtIndex:[indexPath section]] objectForKey:@"COURSE"] addObject:lec];
            [[self tableView] reloadData];
        }];
        // EXECUTION FOR UPDATE
        [editLecture setEditBlock:^void(DBSLecture* lec) {
            [[[courseLectures objectAtIndex:[indexPath section]] objectForKey:@"COURSE"] setObject:lec atIndex:[indexPath row]];
            [[self tableView] reloadData];
        }];
        [[self navigationController] pushViewController:editLecture animated:YES];
    }
    else {
        // EDIT EVENT
        DBSAdminCourseFormViewController *editLecture = [[DBSAdminCourseFormViewController alloc] initEditEvent];
        DBSLecture *lecture = [[[courseLectures objectAtIndex:[indexPath section]] objectForKey:@"COURSE"] objectAtIndex:[indexPath row]];
        [editLecture setLecture:lecture];
        [editLecture setEditBlock:^void(DBSLecture* lec) {
            [[[courseLectures objectAtIndex:[indexPath section]] objectForKey:@"COURSE"] setObject:lec atIndex:[indexPath row]];
            [[self tableView] reloadData];
        }];
        [[self navigationController] pushViewController:editLecture animated:YES];
    }
}

- (void)addTemplate:(id)sender
{
    DBSAdminCourseFormViewController* addLecture = [[DBSAdminCourseFormViewController alloc] initNewTemplate];
    [addLecture setAddBlock:^void(DBSLecture* lec){
        NSString *keyID = [NSString stringWithFormat:@"%@", [lec courseID]];
        NSMutableArray *list = [[NSMutableArray alloc] init];
        [list addObject:lec];
        NSDictionary *courseDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    keyID, @"ID", list, @"COURSE", nil];
        [courseLectures addObject:courseDict];
        [[self tableView] reloadData];
    }];
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:addLecture];
    navController.navigationBar.tintColor = [UIColor blackColor];
    [self presentViewController:navController animated:YES completion:nil];
}

@end
