#import "DBSAdminCourseFormViewController.h"
#import "DBSScheduleService.h"
#import "DBSLecture.h"

@interface DBSAdminCourseFormViewController ()
{
    DBSScheduleService *scheduleService;
}

@end

@implementation DBSAdminCourseFormViewController
{
    NSMutableDictionary *courseInfo;
    NSMutableArray *days;
    NSArray *validDays;
    NSMutableArray *weeks;
    UITextField *activeField;
    
    UIBarButtonItem *cancelButton;
    UIBarButtonItem *doneButton;
    
    BOOL eventable;
}

@synthesize addBlock;
@synthesize editBlock;

- (id)init
{
    self = [super init];
    if (self) {
        validDays = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", nil];
        scheduleService = [DBSScheduleService schedule];
        UINavigationItem *item = [self navigationItem];
        [item setTitle:@"TEMPLATE"];
        courseInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      [NSMutableArray array], @"COURSE",
                      [NSMutableArray array], @"TEACHER",
                      [NSMutableArray array], @"ROOM",
                      [NSMutableArray array], @"DAYS",
                      [NSMutableArray array], @"WEEKS",
                      [NSMutableArray array], @"YEAR",
                      [NSMutableArray array], @"START",
                      [NSMutableArray array], @"STOP", nil];
    }
    return self;
}

- (id)initNewTemplate {
    self = [self init];
    if(self) {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(createTemplate:)];
        cancelButton = [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                        target:self action:@selector(cancelTemplate:)];
        [[self navigationItem] setRightBarButtonItem:doneButton];
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
    }
    return self;
}

- (id)initEditTemplate {
    self = [self init];
    if(self) {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(updateLecture:)];
        [[self navigationItem] setRightBarButtonItem:doneButton];
        eventable =TRUE;
        
    }
    return self;
}

- (id)initEditEvent {
    self = [self init];
    if(self) {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(updateLecture:)];
        [[self navigationItem] setRightBarButtonItem:doneButton];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (eventable)
        self.eventButton.hidden =FALSE;
    if (_lecture) {
        [_courseField setText:[_lecture course]];
        [_teacherField setText:[_lecture teacher]];
        [_roomField setText:[_lecture room]];
        [_courseField setText:[_lecture course]];
        NSString *dayString = [[NSString alloc] init];
        for (NSString *a in [_lecture daysOfWeek]) {
            dayString = [dayString stringByAppendingFormat:@"%@,", a];
        }
        [_dayField setText:dayString];
        NSString *weekString = [[NSString alloc] init];
        for (NSString *b in [_lecture weeks]) {
            weekString = [weekString stringByAppendingFormat:@"%@,", b];
        }
        [_weekField setText:weekString];
        [_yearField setText:[_lecture year]];
        [_startField setText:[_lecture startTime]];
        [_stopField setText:[_lecture stopTime]];
    }
}

- (void)setLecture:(DBSLecture *)lec
{
    _lecture = lec;
    NSString *t = [NSString stringWithFormat:@"%@.%@ %@", [_lecture courseID], [_lecture version], [_lecture course]];
    [[self navigationItem] setTitle:t];
}

- (void)createTemplate:(id)sender
{
    if (!([_teacherField.text isEqualToString:@""]) && !([_courseField.text isEqualToString:@""]) && !([_roomField.text isEqualToString:@""]) && !([_dayField.text isEqualToString:@""]) && !([_weekField.text isEqualToString:@""]) && !([_yearField.text isEqualToString:@""]) && !([_startField.text isEqualToString:@""]) && !([_stopField.text isEqualToString:@""]))
    {
        [courseInfo setValue:_courseField.text forKey:@"COURSE"];
        [courseInfo setValue:_teacherField.text forKey:@"TEACHER"];
        [courseInfo setValue:_roomField.text forKey:@"ROOM"];
        [courseInfo setValue:_yearField.text forKey:@"YEAR"];
        [courseInfo setValue:_startField.text forKey:@"START"];
        [courseInfo setValue:_stopField.text forKey:@"STOP"];
        // Validate days monday-friday
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        temp = [[[[_dayField.text stringByReplacingOccurrencesOfString:@" " withString:@""] capitalizedString] componentsSeparatedByString:@","] mutableCopy];
        days = [[NSMutableArray alloc] init];
        for (NSString *day in temp) {
            for (NSString *validDay in validDays) {
                if ([day isEqualToString:validDay]) {
                    [days addObject:day];
                }
            }
        }
        // Validate weeks 1-53
        [courseInfo setValue:days forKey:@"DAYS"];
        temp = [[NSMutableArray alloc] init];
        temp = [[[_weekField.text stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","] mutableCopy];
        weeks = [[NSMutableArray alloc] init];
        for (NSString *week in temp) {
            for (int w=1; w<54; w++) {
                if ([week isEqualToString:[NSString stringWithFormat:@"%d",w]]) {
                    [weeks addObject:week];
                }
            }
        }
        [courseInfo setValue:weeks forKey:@"WEEKS"];
        DBSLecture *lec = [scheduleService createLecture:courseInfo];
        if (lec) {
            addBlock(lec);
        }
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving Failed" message:@"You need to fill out all the fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)createEvent:(id)sender
{
    if (!([_teacherField.text isEqualToString:@""]) && !([_courseField.text isEqualToString:@""]) && !([_roomField.text isEqualToString:@""]) && !([_dayField.text isEqualToString:@""]) && !([_weekField.text isEqualToString:@""]) && !([_yearField.text isEqualToString:@""]) && !([_startField.text isEqualToString:@""]) && !([_stopField.text isEqualToString:@""]))
    {
        [courseInfo setValue:_courseField.text forKey:@"COURSE"];
        [courseInfo setValue:[_lecture courseID] forKey:@"COURSEID"];
        [courseInfo setValue:_teacherField.text forKey:@"TEACHER"];
        [courseInfo setValue:_roomField.text forKey:@"ROOM"];
        [courseInfo setValue:_yearField.text forKey:@"YEAR"];
        [courseInfo setValue:_startField.text forKey:@"START"];
        [courseInfo setValue:_stopField.text forKey:@"STOP"];
        // Validate days monday-friday
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        temp = [[[[_dayField.text stringByReplacingOccurrencesOfString:@" " withString:@""] capitalizedString] componentsSeparatedByString:@","] mutableCopy];
        days = [[NSMutableArray alloc] init];
        for (NSString *day in temp) {
            for (NSString *validDay in validDays) {
                if ([day isEqualToString:validDay]) {
                    [days addObject:day];
                }
            }
        }
        // Validate weeks 1-53
        [courseInfo setValue:days forKey:@"DAYS"];
        temp = [[NSMutableArray alloc] init];
        temp = [[[_weekField.text stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","] mutableCopy];
        weeks = [[NSMutableArray alloc] init];
        for (NSString *week in temp) {
            for (int w=1; w<54; w++) {
                if ([week isEqualToString:[NSString stringWithFormat:@"%d",w]]) {
                    [weeks addObject:week];
                }
            }
        }
        [courseInfo setValue:weeks forKey:@"WEEKS"];
        DBSLecture *lec = [scheduleService createLectureEvent:courseInfo];
        if (lec) {
            addBlock(lec);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving Failed" message:@"You need to fill out all the fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)updateLecture:(id)sender
{
    if (!([_teacherField.text isEqualToString:@""]) && !([_courseField.text isEqualToString:@""]) && !([_roomField.text isEqualToString:@""]) && !([_dayField.text isEqualToString:@""]) && !([_weekField.text isEqualToString:@""]) && !([_yearField.text isEqualToString:@""]) && !([_startField.text isEqualToString:@""]) && !([_stopField.text isEqualToString:@""]))
    {
        [courseInfo setObject:[_lecture couchDBId] forKey:@"COUCHID"];
        [courseInfo setObject:[_lecture couchDBRev] forKey:@"COUCHREV"];
        [courseInfo setValue:[_lecture courseID] forKey:@"COURSEID"];
        [courseInfo setValue:[_lecture version] forKey:@"VERSION"];
        [courseInfo setValue:_courseField.text forKey:@"COURSE"];
        [courseInfo setValue:_teacherField.text forKey:@"TEACHER"];
        [courseInfo setValue:_roomField.text forKey:@"ROOM"];
        [courseInfo setValue:_yearField.text forKey:@"YEAR"];
        [courseInfo setValue:_startField.text forKey:@"START"];
        [courseInfo setValue:_stopField.text forKey:@"STOP"];
        // Validate days monday-friday
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        temp = [[[[_dayField.text stringByReplacingOccurrencesOfString:@" " withString:@""] capitalizedString] componentsSeparatedByString:@","] mutableCopy];
        days = [[NSMutableArray alloc] init];
        for (NSString *day in temp) {
            for (NSString *validDay in validDays) {
                if ([day isEqualToString:validDay]) {
                    [days addObject:day];
                }
            }
        }
        // Validate weeks 1-53
        [courseInfo setValue:days forKey:@"DAYS"];
        temp = [[NSMutableArray alloc] init];
        temp = [[[_weekField.text stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","] mutableCopy];
        weeks = [[NSMutableArray alloc] init];
        for (NSString *week in temp) {
            for (int w=1; w<54; w++) {
                if ([week isEqualToString:[NSString stringWithFormat:@"%d",w]]) {
                    [weeks addObject:week];
                }
            }
        }
        [courseInfo setValue:weeks forKey:@"WEEKS"];
        DBSLecture* lec = [scheduleService updateLecture:courseInfo];
        if (lec) {
            editBlock(lec);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving Failed" message:@"You need to fill out all the fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)cancelTemplate:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)courseExit:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)teacherExit:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)roomExit:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)dayExit:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)weekExit:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)yearExit:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)startExit:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)stopExit:(id)sender
{
    [sender resignFirstResponder];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _superHejScroll.contentInset = contentInsets;
    _superHejScroll.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [_superHejScroll setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _superHejScroll.contentInset = contentInsets;
    _superHejScroll.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

@end
