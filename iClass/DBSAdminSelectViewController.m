#import "DBSAdminSelectViewController.h"
#import "DBSAdminCourseViewController.h"
#import "DBSDayViewController.h"
#import "DBSAdminNoteCreateViewController.h"
#import "DBSAdminCreateMessageViewController.h"

@interface DBSAdminSelectViewController ()

@end

@implementation DBSAdminSelectViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        UINavigationItem *item = [self navigationItem];
        [item setTitle:@"Admin"];
        UIBarButtonItem *buttonExit = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Exit"
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(exitAdmin:)];
        [[self navigationItem] setLeftBarButtonItem:buttonExit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)exitAdmin:(id)sender
{
    DBSDayViewController *dayController = [[DBSDayViewController alloc] init];
    dayController.delegate = delegate;
    [delegate setRootViewController:dayController];
}

- (IBAction)toCourses:(id)sender
{
    DBSAdminCourseViewController *lectureList = [[DBSAdminCourseViewController alloc] init];
    [[self navigationController] pushViewController:lectureList animated:YES];
}

- (IBAction)toNotes:(id)sender
{
    DBSAdminNoteCreateViewController *noteCreate = [[DBSAdminNoteCreateViewController alloc]init];
    [[self navigationController] pushViewController:noteCreate animated:YES];
}

- (IBAction)toMessages:(id)sender
{
    DBSAdminCreateMessageViewController *messageCreate = [[DBSAdminCreateMessageViewController alloc]init];
    [[self navigationController] pushViewController:messageCreate animated:YES];
}
@end
