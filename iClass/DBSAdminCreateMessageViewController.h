#import <UIKit/UIKit.h>

@interface DBSAdminCreateMessageViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextField;

- (IBAction)mailTextFieldDo:(id)sender;

- (IBAction)clickBG:(id)sender;


@end
