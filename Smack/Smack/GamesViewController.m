//
//  GamesViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "GamesViewController.h"

@interface GamesViewController ()

@end

@implementation GamesViewController

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numgames: %d",[self.games count]);
	return [self.games count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"gameCell";
    
    GameCell *cell = [self.gamesTableView
                      dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    Game *game = [self.games objectAtIndex: [indexPath row]];
    cell.player1Name.text = game.player1Name;
    cell.player1Score.text = [game.player1Score stringValue];
    cell.player2Name.text = game.player2Name;
    cell.player2Score.text = [game.player2Score stringValue];
    
    Team *team1 = [[TeamData FifaTeams] getTeamAtIndex:[game.team1Index intValue]];
    
    UIImage *image1 = [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:team1.name]];
    [cell.team1Image setImage:(UIImage *) image1];
    
    Team *team2 = [[TeamData FifaTeams] getTeamAtIndex:[game.team2Index intValue]];
    UIImage *image2 = [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:team2.name]];
    [cell.team2Image setImage:(UIImage *) image2];
    
    return cell;
}

@end
