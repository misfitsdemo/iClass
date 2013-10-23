#import <UIKit/UIKit.h>

@interface DBSDayViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *stopTextLabel;



@end
