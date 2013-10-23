#import <UIKit/UIKit.h>

@interface DBSWeekLayerViewController : UIViewController
{
    NSString* userName;
}

@property (nonatomic, weak) id delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *weekView;
@property (weak, nonatomic) IBOutlet UITableView *weekTable;

@end
