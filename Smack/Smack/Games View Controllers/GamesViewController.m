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

-(void)reloadView
{
    [self.gamesTableView reloadData];
}

-(void)gameRemoved
{
    [self.gameViewDelegate gameRemoved];
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
    
    cell.team1Image.image = [UIImage imageNamed:team1.logoName];
    
    //UIImage *image1 = [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:team1.teamName]];
    //[cell.team1Image setImage:(UIImage *) image1];
    
    Team *team2 = [[TeamData FifaTeams] getTeamAtIndex:[game.team2Index intValue]];
    cell.team2Image.image = [UIImage imageNamed:team2.logoName];
    
    //UIImage *image2 = [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:team2.teamName]];
    //[cell.team2Image setImage:(UIImage *) image2];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	gameToShow = [self.games objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"selectGameSegue" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"selectGameSegue"])
    {
        GameInfoViewController *controller = (GameInfoViewController*) segue.destinationViewController;
        NSIndexPath *selectedRowIndex = [self.gamesTableView indexPathForSelectedRow];

        controller.selectedGame = [self.games objectAtIndex:selectedRowIndex.row];
        [controller setGameInfoDelegate:self];
        
        [self.gamesTableView deselectRowAtIndexPath:selectedRowIndex animated:YES];
    }
}

@end
