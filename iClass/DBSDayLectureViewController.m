#import "DBSDayLectureViewController.h"
#import "DBSScheduleService.h"
#import "DBSDayViewCell.h"
#import "DBSLecture.h"

@interface DBSDayLectureViewController ()
{
    DBSScheduleService *schedule;
    NSDictionary *list;
}

@end

@implementation DBSDayLectureViewController


- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorColor = [UIColor clearColor];
        schedule = [DBSScheduleService schedule];
        
        list = [schedule getDayLectures:0];
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
    UINib *nib = [UINib nibWithNibName:@"DBSDayViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"DBSDayViewCell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGSize lectureView;
    lectureView = CGSizeMake(320, (([[list objectForKey:@"LECTURES"] count])*70)+500);
    [self.tableView setContentSize:lectureView];
}

- (void)refreshTable:(int)day
{
    list = [schedule getDayLectures:day];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[list objectForKey:@"LECTURES"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBSDayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBSDayViewCell"];
    DBSLecture *lec = [[list objectForKey:@"LECTURES"] objectAtIndex:[indexPath row]];
    [[cell courseLabel] setText:[lec course]];
    [[cell teacherLabel] setText:[lec teacher]];
    [[cell roomLabel] setText:[lec room]];
    [[cell startLabel] setText: [lec startTime]];
    [[cell stopLabel] setText: [lec stopTime]];
    
    //    UIFont *crayonFont = [UIFont fontWithName:@"DK Crayon Crumble" size:20];
    //    //UIFont *handwritingFont = [UIFont fontWithName:@"Schoolbell" size:30];
    //    cell.courseLabel.font = crayonFont;
    //    cell.teacherLabel.font = crayonFont;
    //    cell.roomLabel.font = crayonFont;
    //    cell.startLabel.font = crayonFont;
    //    cell.stopLabel.font = crayonFont;
    //    cell.startTextLabel.font = crayonFont;
    //    cell.stopTextLabel.font = crayonFont;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

@end
