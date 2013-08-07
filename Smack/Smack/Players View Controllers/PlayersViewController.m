//
//  PlayersViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "PlayersViewController.h"
#import "SVProgressHUD.h"
#import <Parse/Parse.h>


@interface PlayersViewController ()

@end

@implementation PlayersViewController

@synthesize players;


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadView
{
    [self.playersTable reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.players count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"playerCell";
    
    PlayerCell *cell = [self.playersTable
                        dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PlayerCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Player *player = [self.players objectAtIndex: [indexPath row]];
    cell.nameLabel.text = player.name;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"selectPlayerSegue" sender:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"delete player");
        
        Player *player = [players objectAtIndex:indexPath.row];
        
        NSLog(@"player object %@", player.objectId);
        
        PFQuery *removePlayerQuery = [PFQuery queryWithClassName:@"GroupToUser"];
        
        [SVProgressHUD showWithStatus:@"Removing user from group"];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(queue, ^{
            
            
            
            PFObject *obj = [removePlayerQuery getObjectWithId:player.objectId];
            
            [obj delete];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.delegate playerRemoved];
                
                [SVProgressHUD showSuccessWithStatus:@"Done Enjoy"];
                
            });
            
        });

    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectPlayerSegue"]) {
        // Get destination view
        PlayerInfoViewController *playerVC = (PlayerInfoViewController*)[segue destinationViewController];
        
        // Pass the information to your destination view
        NSIndexPath *selectedRowIndex = [self.playersTable indexPathForSelectedRow];
        Player *selectedPlayer = [players objectAtIndex:selectedRowIndex.row];
        playerVC.selectedPlayer = selectedPlayer;
        playerVC.games = self.games;
        [self.playersTable deselectRowAtIndexPath:selectedRowIndex animated:YES];

    }
}

@end
