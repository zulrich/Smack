//
//  AddPlayerViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "AddPlayerViewController.h"

@interface AddPlayerViewController ()
{
    NSString *selectedFbId;
    NSString *selectedName;
    NSMutableArray *fbFriends;
    NSMutableArray *filteredFbFriends;
    BOOL canSave;
}

@end

@implementation AddPlayerViewController

@synthesize groupID;
@synthesize groupName;

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
    NSLog(@"groupid %@", self.groupID);
    [self sendRequest];

}

-(void)viewDidAppear:(BOOL)animated
{
    canSave = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sortAtoZ{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name"  ascending:YES];
    [fbFriends sortUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
}

-(void)sendRequest
{
    FBRequest *request = [FBRequest requestForGraphPath:@"me/friends"];
    [request startWithCompletionHandler:^(FBRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        if (!error) {
            // result will contain an array with your user's friends in the "data" key
            NSArray *friendObjects = [result objectForKey:@"data"];
            NSMutableArray *tempFbFriends = [NSMutableArray arrayWithCapacity:friendObjects.count];
            // Create a list of friends' Facebook IDs
            for (NSDictionary *friendObject in friendObjects) {
                NSString *tempName = [friendObject objectForKey:@"name"];
                NSString *tempFbId = [friendObject objectForKey:@"id"];
                NSArray *objs = [NSArray arrayWithObjects:tempName,tempFbId, nil];
                NSArray *keys = [NSArray arrayWithObjects:@"name",@"fbId",nil];
                
                NSDictionary *tempFriend = [[NSDictionary alloc] initWithObjects:objs forKeys:keys];
                [tempFbFriends addObject:tempFriend];
     
            }
            
            fbFriends = [[NSMutableArray alloc] initWithArray:tempFbFriends];
            filteredFbFriends = [NSMutableArray arrayWithCapacity:[fbFriends count]];
            [self sortAtoZ];

            //NSLog(@"friends: %@",[fbFriends description]);
            [self.friendsTableView reloadData];
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredFbFriends count];
    }
	else
	{
        return [fbFriends count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"playerCell";
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PlayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *name = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        name = [[filteredFbFriends objectAtIndex:[indexPath row]] valueForKey:@"name"];
    }
	else
	{
        name = [[fbFriends objectAtIndex:[indexPath row]] valueForKey:@"name"];
    }
    
    cell.textLabel.text = name;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
    
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        selectedName = [[filteredFbFriends objectAtIndex:indexPath.row] valueForKey:@"name"];
        selectedFbId = [[filteredFbFriends objectAtIndex:indexPath.row] valueForKey:@"fbId"];
    }
	else
	{
        selectedName = [[fbFriends objectAtIndex:indexPath.row] valueForKey:@"name"];
        selectedFbId = [[fbFriends objectAtIndex:indexPath.row] valueForKey:@"fbId"];
    }
    
    canSave = YES;
    
    [self savePressed:nil];
    
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[filteredFbFriends removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    NSArray *tempArray = [fbFriends filteredArrayUsingPredicate:predicate];
    
    filteredFbFriends = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (IBAction)savePressed:(id)sender
{
    if(!canSave)
    {
        [SVProgressHUD showErrorWithStatus:@"Please Select a Name"];
        return;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        PFObject *playerObject = [PFObject objectWithClassName:@"GroupToUser"];
        [playerObject setObject:selectedName forKey:@"Name"];
        [playerObject setObject:[NSNumber numberWithInt:0] forKey:@"Losses"];
        [playerObject setObject:[NSNumber numberWithInt:0] forKey:@"Wins"];
        [playerObject setObject:[NSNumber numberWithInt:0] forKey:@"Draws"];
        [playerObject setObject:[NSNumber numberWithInt:0] forKey:@"WLR"];
        [playerObject setObject:self.groupID forKey:@"GroupId"];
        [playerObject setObject:selectedFbId forKey:@"fbId"];
        [playerObject setObject:self.groupName forKey:@"GroupName"];
        [playerObject save];
        
        [self.addPlayerDelegate newPlayerAdded];
    });
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
