//
//  LeaderboardViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/12/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "LeaderboardViewController.h"

@interface LeaderboardViewController ()

@end

@implementation LeaderboardViewController

@synthesize players;
@synthesize games;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadView{
    NSComparator sortDescending = ^(Player *p1, Player *p2) {
        if ([p2.WLR compare:p1.WLR] == NSOrderedSame) {
            if([p2.wins compare:p1.wins] == NSOrderedSame){
                if([p2.losses compare:p1.losses] == NSOrderedSame)
                    return [p2.draws compare:p1.draws];
                return [p2.losses compare:p1.losses];
            }
            return [p2.wins compare:p1.wins];
        }
        
        return [p2.WLR compare:p1.WLR];
    };
    
    [self.players sortUsingComparator:sortDescending];
    [self.leaderboardTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numplayers: %d",[self.players count]);
	return [self.players count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"leaderboardCell";
    
    LeaderboardCell *cell = [self.leaderboardTableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LeaderboardCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Player *player = [self.players objectAtIndex: [indexPath row]];
    cell.rank.text = [NSString stringWithFormat:@"%d", [indexPath row] + 1];
    cell.name.text = player.name;
    cell.winLabel.text = [player.wins stringValue];
    cell.loseLabel.text = [player.losses stringValue];
    cell.drawLabel.text = [player.draws stringValue];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"leaderSelectPlayerSegue" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"leaderSelectPlayerSegue"]) {
        PlayerInfoViewController *controller = (PlayerInfoViewController*) segue.destinationViewController;
        NSIndexPath *selectedRowIndex = [self.leaderboardTableView indexPathForSelectedRow];

        [self.players objectAtIndex:selectedRowIndex.row];
        
        [controller setSelectedPlayer:[self.players objectAtIndex:selectedRowIndex.row]];
        [controller setGames:self.games];
        
        [self.leaderboardTableView deselectRowAtIndexPath:selectedRowIndex animated:YES];
        
    }
}

@end
