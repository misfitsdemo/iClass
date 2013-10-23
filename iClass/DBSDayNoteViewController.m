#import "DBSDayNoteViewController.h"
#import "DBSScheduleService.h"
#import "DBSDayNoteCell.h"
#import "DBSNote.h"

@interface DBSDayNoteViewController ()
{
    DBSScheduleService *schedule;
    NSDictionary *list;
}

@end

@implementation DBSDayNoteViewController


- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorColor = [UIColor clearColor];
        schedule = [DBSScheduleService schedule];
        list = [schedule getDayNotes:0];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"DBSDayNoteCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"DBSDayNoteCell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGSize noteView = CGSizeMake(320, (([[list objectForKey:@"NOTES"] count])*20));
    [self.tableView setContentSize:noteView];
}

- (void)refreshTable:(int)day
{
    list = [schedule getDayNotes:day];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[list objectForKey:@"NOTES"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBSDayNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBSDayNoteCell"];
    DBSNote *note = [[list objectForKey:@"NOTES"] objectAtIndex:[indexPath row]];
    [[cell noteLabel] setText:[note text]];
    
    //    UIFont *handwritingFont = [UIFont fontWithName:@"Schoolbell" size:15];
    //    cell.noteLabel.font = handwritingFont;
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 17;
}

@end
