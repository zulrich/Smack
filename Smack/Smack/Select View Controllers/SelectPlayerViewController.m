//
//  SelectPlayerViewController.m
//  FifaSmack
//
//  Created by Zack Ulrich on 1/4/13.
//
//

#import "SelectPlayerViewController.h"
#import "PlayerCell.h"

@interface SelectPlayerViewController ()

@end

@implementation SelectPlayerViewController
@synthesize tableView;
@synthesize players;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"players count %d", [self.players count]);
	return [self.players count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"playerCell";
    PlayerSelectCell *cell = [self.tableView
                        dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PlayerSelectCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Player *player = [self.players objectAtIndex: [indexPath row]];
    cell.nameLabel.text = player.name;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Player *player = [players objectAtIndex:indexPath.row];
	[self.delegate playerPicker:self didPickPlayer:player];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
