#import <UIKit/UIKit.h>
@class DBSLecture;

@interface DBSAdminCourseFormViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong)DBSLecture* lecture;
@property (nonatomic, copy) void (^addBlock)(DBSLecture*);
@property (nonatomic, copy) void (^editBlock)(DBSLecture*);

- (id)initNewTemplate;
- (id)initEditTemplate;
- (id)initEditEvent;
- (void)setLecture:(DBSLecture*)lecture;

@property (weak, nonatomic) IBOutlet UITextField *courseField;
@property (weak, nonatomic) IBOutlet UITextField *teacherField;
@property (weak, nonatomic) IBOutlet UITextField *roomField;
@property (weak, nonatomic) IBOutlet UITextField *dayField;
@property (weak, nonatomic) IBOutlet UITextField *weekField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *startField;
@property (weak, nonatomic) IBOutlet UITextField *stopField;

@property (strong, nonatomic) IBOutlet UIScrollView *superHejScroll;
@property (weak, nonatomic) IBOutlet UIButton *eventButton;

- (IBAction)courseExit:(id)sender;
- (IBAction)teacherExit:(id)sender;
- (IBAction)roomExit:(id)sender;
- (IBAction)dayExit:(id)sender;
- (IBAction)weekExit:(id)sender;
- (IBAction)yearExit:(id)sender;
- (IBAction)startExit:(id)sender;
- (IBAction)stopExit:(id)sender;

- (IBAction)createEvent:(id)sender;

@end
