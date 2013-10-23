#import <UIKit/UIKit.h>


@interface DBSDayViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id delegate;
@property (strong, nonatomic) UIAlertView *alertView;
@property (nonatomic, copy) void (^refreshBlock)(void);

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIButton *noteButton;
@property (weak, nonatomic) IBOutlet UIButton *inboxButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *adminButton;

@property (weak, nonatomic) IBOutlet UIScrollView *lectureView;
@property (weak, nonatomic) IBOutlet UIView *noteView;
@property (weak, nonatomic) IBOutlet UITableView *lectureTable;
@property (weak, nonatomic) IBOutlet UITableView *noteTable;
@property (strong, nonatomic) IBOutlet UIView *creditView;

- (IBAction)showCredit:(id)sender;
- (IBAction)showNotes:(id)sender;
- (IBAction)toInbox:(id)sender;
- (IBAction)doSync:(id)sender;
- (IBAction)toAdmin:(id)sender;
- (IBAction)handleSwipe:(id)sender;

@end
