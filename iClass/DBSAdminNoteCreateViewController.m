#import "DBSAdminNoteCreateViewController.h"
#import "DBSScheduleService.h"
#import "DBSDatabaseService.h"
#import "DBSLecture.h"

@interface DBSAdminNoteCreateViewController ()

@end

@implementation DBSAdminNoteCreateViewController
{
    NSMutableDictionary *notesDic;
    NSMutableArray *allectures;
    NSString *lectureName;
    DBSDatabaseService *dataBase;
    DBSScheduleService *schedule;
    NSArray *validDays;
    NSMutableArray *templateLectures;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        validDays = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", nil];
        dataBase = [DBSDatabaseService database];
        allectures = [[NSMutableArray alloc] initWithArray:[dataBase getLectures]];
        notesDic = [[NSMutableDictionary alloc] init];
        schedule = [DBSScheduleService schedule];
        templateLectures = [[NSMutableArray alloc] init];
        
        for (DBSLecture *lec in allectures) {
            if ([lec.version isEqual:@"1"]) {
                [templateLectures addObject:lec];
            }
        }
        
        UINavigationItem *item = [self navigationItem];
        [item setTitle:@"Add note"];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(newNote:)];
        [item setRightBarButtonItem:doneButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _coursePickerView.delegate = self;
    _coursePickerView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [templateLectures count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[templateLectures objectAtIndex:row] course];
}

-(void)newNote:(id)sender
{
    // Validate day monday-friday
    BOOL isValid =FALSE;
    NSString *temp = [[_superDayTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] capitalizedString];;
    for (NSString *validDay in validDays) {
        if ([temp isEqualToString:validDay])
            isValid =TRUE;
    }
    if (!isValid)
        [_superDayTextField setText:@""];
    // Validate weeks 1-53
    isValid =FALSE;
    temp =
    [_superWeekTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    for (int w=1; w<54; w++) {
        if ([temp isEqualToString:[NSString stringWithFormat:@"%d",w]])
            isValid =TRUE;
    }
    if (!isValid)
        [_superWeekTextField setText:@""];
    
    if (!([_noteTextView.text isEqualToString:@""]) && !([_coursePickerView isEqual:NULL]) &&
        !([_superDayTextField.text isEqualToString:@""]) && !([_superWeekTextField.text isEqualToString:@""])) {
        [notesDic setValue:_noteTextView.text forKey:@"TEXT"];
        [notesDic setValue:_superWeekTextField.text forKey:@"WEEK"];
        [notesDic setValue:_superDayTextField.text forKey:@"DAY"];
        
        for (DBSLecture *lec in templateLectures) {
            if (lec.course == lectureName) {
                [notesDic setValue:lec.courseID forKey:@"COURSEID"];
            }
        }
        [schedule createNote:notesDic];
        _noteTextView.text = @"Write a note here...";
        _superDayTextField.text = @"";
        _superWeekTextField.text = @"";
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving Failed" message:@"You need to fill out all the fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    lectureName = [[templateLectures objectAtIndex:row] course];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)superDayEnd:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)superWeekEnd:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)clickBG:(id)sender {
    [[self view] endEditing:YES];
}
@end
