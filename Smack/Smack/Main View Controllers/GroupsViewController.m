//
//  GroupsViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "GroupsViewController.h"
#import "GroupCell.h"


@interface GroupsViewController ()

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation GroupsViewController

@synthesize groups;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.tableView.userInteractionEnabled = NO;
    [self getGroups];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    //refreshControl.tintColor = [UIColor magentaColor];
    [refreshControl addTarget:self action:@selector(refreshGroups) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    groups = [[NSMutableArray alloc] init];
    
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error)
        {
            NSLog(@"Valid facebook session");
            
        }
        else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"] isEqualToString: @"OAuthException"])
        { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            [self logoutRequested:nil];
        }
        else
        {
            NSLog(@"Some other error: %@", error);
        }
        

    }];
    
}

-(void) refreshGroups
{
    
    [self getGroups];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getGroups
{
    
    [SVProgressHUD showWithStatus:@"Loading Groups"];
    PFQuery *query = [PFQuery queryWithClassName:@"GroupToUser"];
    [query whereKey:@"fbId" equalTo:[[PFUser currentUser] objectForKey:@"fbId"]];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            [groups removeAllObjects];
            // The find succeeded.
            for(PFObject *groupToUserObject in objects)
            {
                Group *groupObj = [[Group alloc] initWithName:[groupToUserObject objectForKey:@"GroupName"] withID:[groupToUserObject objectForKey:@"GroupId"]];
                [groups addObject:groupObj];
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error here: %@ %@", error, [error userInfo]);
        }
        
        self.tableView.userInteractionEnabled = YES;
        [self.tableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"Done Enjoy"];

    }];
    
    

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GroupCell";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Group *group = [groups objectAtIndex:indexPath.row];
    cell.groupLabel.text = group.groupName;
        
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"FifaTabSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FifaTabSegue"]) {
        // Get destination view
        SmackTabViewController *smackVC = (SmackTabViewController*)[segue destinationViewController];
        
        // Pass the information to your destination view
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        NSLog(@"Selected Row index %d ", selectedRowIndex.row);
        Group *selectedGroup = [groups objectAtIndex:selectedRowIndex.row];
        smackVC.groupID = selectedGroup.groupID;
        smackVC.groupName = selectedGroup.groupName;
    }
}

- (IBAction)logoutRequested:(id)sender
{
    
    [PFUser logOut]; // Log out
        
    // Return to login page
    [self performSegueWithIdentifier:@"returnBackSegue" sender:nil];
}
@end
