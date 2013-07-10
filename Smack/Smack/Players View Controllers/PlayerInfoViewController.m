//
//  PlayerInfoViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/12/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "PlayerInfoViewController.h"

@interface PlayerInfoViewController ()
{
    NSArray *usersGames;
}

@end

@implementation PlayerInfoViewController

@synthesize games;
@synthesize selectedPlayer;

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
    self.playerNameLabel.text = self.selectedPlayer.name;
    //playerFavTeam.text = player.favoriteTeam;
    self.playerRecordLabel.text = [NSString stringWithFormat:@"%d - %d - %d", self.selectedPlayer.wins.intValue, self.selectedPlayer.losses.intValue, self.selectedPlayer.draws.intValue];
    NSPredicate *Predicate =
    [NSPredicate predicateWithFormat:@"player2Id contains %@ OR player1Id contains %@ ", self.selectedPlayer.objectId, self.selectedPlayer.objectId];
    usersGames = [games filteredArrayUsingPredicate:Predicate];
    
    NSLog(@"player selected: %@", self.selectedPlayer.name);
    NSLog(@"games count: %d", [games count]);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [usersGames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"gameCell";
    
    GameCell *cell = [self.playerRecordTableView
                      dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    Game *game = [usersGames objectAtIndex: [indexPath row]];
    cell.player1Name.text = game.player1Name;
    cell.player1Score.text = [game.player1Score stringValue];
    cell.player2Name.text = game.player2Name;
    cell.player2Score.text = [game.player2Score stringValue];
    
    Team *team1 = [[TeamData FifaTeams] getTeamAtIndex:[game.team1Index intValue]];
    cell.team1Image.image = [UIImage imageNamed:team1.logoName];
    
    NSLog(@"image name: %@", team1.logoName);
    
    Team *team2 = [[TeamData FifaTeams] getTeamAtIndex:[game.team2Index intValue]];
    //UIImage *image2 = [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:team2.teamName]];
    //[cell.team2Image setImage:(UIImage *) image2];
    
    cell.team2Image.image = [UIImage imageNamed:team2.logoName];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
