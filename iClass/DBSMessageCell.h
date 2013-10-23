#import <UIKit/UIKit.h>

@interface DBSMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *senderTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextField;

@end
