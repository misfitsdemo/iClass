#import "DBSMessageViewController.h"
#import "DBSMessageCell.h"
#import "DBSScheduleService.h"
#import "DBSMessage.h"
#import "DBSDayViewController.h"

@interface DBSMessageViewController ()

@end

@implementation DBSMessageViewController
{
    DBSScheduleService *schedule;
    NSMutableArray *messages;
}
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        schedule = [DBSScheduleService schedule];
        messages = [[NSMutableArray alloc] init];
        messages = [[schedule getMessages] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"DBSMessageCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"DBSMessageCell"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBSMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBSMessageCell"];
    DBSMessage *message = [messages objectAtIndex:[indexPath row]];
    [[cell senderTextLabel] setText:[message sender]];
    [[cell messageTextField] setText:[message text]];
    //DBSMessage *message = [messages objectAtIndex:[indexPath row]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

@end