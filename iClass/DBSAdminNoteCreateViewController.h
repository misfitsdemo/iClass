#import <UIKit/UIKit.h>

@interface DBSAdminNoteCreateViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *coursePickerView;

@property (weak, nonatomic) IBOutlet UITextField *superDayTextField;
@property (weak, nonatomic) IBOutlet UITextField *superWeekTextField;
- (IBAction)superDayEnd:(id)sender;
- (IBAction)superWeekEnd:(id)sender;
- (IBAction)clickBG:(id)sender;


@end
