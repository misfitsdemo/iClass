#import "DBSWeekLayerViewController.h"
#import "DBSDatabaseService.h"
#import "DBSScheduleService.h"
#import "DBSWeekViewController.h"
#import "DBSDayViewController.h"
#import "DBSLecture.h"
#import "DBSNote.h"
#import "DBSUser.h"
#import "DBSMessage.h"
#import "DBSWeekViewCell.h"

@interface DBSWeekLayerViewController ()
{
    DBSWeekViewController *weekSchedule;
    DBSUser *user;
}

@end

@implementation DBSWeekLayerViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    weekSchedule = [[DBSWeekViewController alloc] init];
    [_weekTable addSubview:weekSchedule.view];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (fromInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||
        fromInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        DBSDayViewController *dayController = [[DBSDayViewController alloc] init];
        dayController.delegate = delegate;
        [delegate setRootViewController:dayController];
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
