#import "DBSMessageLayerViewController.h"
#import "DBSMessageViewController.h"
#import "DBSDayViewController.h"

@interface DBSMessageLayerViewController ()
{
    DBSMessageViewController *inbox;
}

@end

@implementation DBSMessageLayerViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        UINavigationItem *item = [self navigationItem];
        [item setTitle:@"Messages"];
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
    inbox = [[DBSMessageViewController alloc] init];
    [_messageTable addSubview:inbox.view];
}

- (void)exitAdmin:(id)sender
{
    DBSDayViewController *dayController = [[DBSDayViewController alloc] init];
    dayController.delegate = delegate;
    [delegate setRootViewController:dayController];
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
