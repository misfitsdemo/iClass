#import "DBSDatabaseService.h"
#import "DBSScheduleService.h"
#import "DBSWeekViewController.h"
#import "DBSDayViewController.h"
#import "DBSLecture.h"
#import "DBSNote.h"
#import "DBSUser.h"
#import "DBSMessage.h"
#import "DBSWeekViewCell.h"

@implementation DBSWeekViewController
{
    DBSScheduleService *schedule;
}

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorColor = [UIColor clearColor];
        schedule = [DBSScheduleService schedule];
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
    UINib *nib = [UINib nibWithNibName:@"DBSWeekViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"DBSWeekViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[schedule getWeekLectures] objectAtIndex:section] objectForKey:@"LECTURES"] count]+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView.sectionFooterHeight =0;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBSWeekViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBSWeekViewCell"];
    if ([indexPath row]==0) {
        // DAY HEADER
        [[cell dayLabel] setText:[[[schedule getWeekLectures] objectAtIndex:[indexPath section]] objectForKey:@"DAY"]];
        [[cell courseLabel] setText:@""];
        [[cell startLabel] setText:@""];
        [[cell stopLabel] setText:@""];
        return cell;
    }
    else {
        // COURSE OBJECTS
        NSArray *lectures = [[[schedule getWeekLectures] objectAtIndex:[indexPath section]] objectForKey:@"LECTURES"];
        DBSLecture *lec = [lectures objectAtIndex:([indexPath row]-1)];
        [[cell dayLabel] setText:@""];
        [[cell courseLabel] setText: [lec course]];
        [[cell startLabel] setText: [NSString stringWithFormat:@"%@ -", [lec startTime]]];
        [[cell stopLabel] setText: [NSString stringWithFormat:@"%@", [lec stopTime]]];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

@end
