#import "DBSAdminCreateMessageViewController.h"
#import "DBSMessage.h"
#import "DBSDatabaseService.h"
#import "DBSDayViewController.h"
#import "DBSUser.h"
#import "DBSScheduleService.h"

@interface DBSAdminCreateMessageViewController ()

@end

@implementation DBSAdminCreateMessageViewController
{
    NSMutableArray *allReceivers;
    NSMutableDictionary *messageDictionary;
    DBSDatabaseService *dataBase;
    DBSScheduleService *schedule;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataBase = [DBSDatabaseService database];
        messageDictionary = [[NSMutableDictionary alloc]init];
        schedule = [DBSScheduleService schedule];
        UINavigationItem *item = [self navigationItem];
        [item setTitle:@"New Message"];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(newMessage:)];
        [item setRightBarButtonItem:doneButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)mailTextFieldDo:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)clickBG:(id)sender {
    [[self view] endEditing:YES];
}

-(void)newMessage:(id)sender
{
    if (!([_mailTextField.text isEqualToString:@""]) && !([_messageTextField.text isEqualToString:@""])) {
        [messageDictionary setValue:_messageTextField.text forKey:@"TEXT"];
        [messageDictionary setValue:[[[NSUserDefaults standardUserDefaults]objectForKey:@"SchoolApp_user"] objectForKey:@"MAIL"] forKey:@"SENDER"];
        
        allReceivers = [[NSMutableArray alloc] init];
        allReceivers = [[[_mailTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","] mutableCopy];
        [messageDictionary setValue:allReceivers forKey:@"RECEIVER"];
        
        [schedule createMessage:messageDictionary];
        _messageTextField.text = @"";
        _mailTextField.text = @"";
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving Failed" message:@"You need to fill out all the fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}








@end
