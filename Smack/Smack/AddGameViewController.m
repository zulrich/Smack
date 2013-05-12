//
//  AddGameViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "AddGameViewController.h"

@interface AddGameViewController ()
{
    BOOL selectTeam1;
    BOOL selectTeam2;
    BOOL selectPlayer1;
    BOOL selectPlayer2;
    
    BOOL player1Updated;
    BOOL player2Updated;
    BOOL gameDataSaved;
    BOOL failed;
}

@end


@implementation AddGameViewController

@synthesize player1ImageView;
@synthesize player2ImageView;
@synthesize team1Button;
@synthesize team2Button;
@synthesize player1ScoreLabel;
@synthesize player2ScoreLabel;
@synthesize groupId;
@synthesize team1;
@synthesize team2;
@synthesize player1;
@synthesize player2;
@synthesize players;
@synthesize team1Index;
@synthesize team2Index;
@synthesize team1Score;
@synthesize team2Score;

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
    NSLog(@"players count add game %d", [self.players count]);
    
    team1Score = [[NSNumber alloc] initWithInt:0];
    team2Score = [[NSNumber alloc] initWithInt:0];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playerPicker:(SelectPlayerViewController *)picker didPickPlayer:(Player *)playerName;
{
    if (selectPlayer1) {
        player1 = playerName;
        [self.player1Button setTitle:player1.name forState:UIControlStateNormal];
    }
    else if (selectPlayer2) {
        player2 = playerName;
        [self.player2Button setTitle:player2.name forState:UIControlStateNormal];
    }
}

-(void)teamPicker:(SelectTeamViewController *)picker didPickTeamIndex:(NSNumber *)teamName didPickTeam:(Team *)theTeamObject
{
    //NSLog(@"teamIndex: %d", [theTeamIndex intValue]);
    if (selectTeam1) {
        team1Index = theTeamObject.index;
        team1 = theTeamObject;
        [self.team1Button setTitle:theTeamObject.name forState:UIControlStateNormal];
        NSLog(@"Name is %@", team1.name);
        UIImage *image =  [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:team1.name]];
        [self.player1ImageView setImage:(UIImage *) image];
    }
    else if (selectTeam2) {
        NSLog(@"select t2");
        team2Index = theTeamObject.index;
        team2 = theTeamObject;
        [self.team2Button setTitle:team2.name forState:UIControlStateNormal];
        //NSString *name = team2.name;
        UIImage *image =  [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:team2.name]];
        [self.player2ImageView setImage:(UIImage *) image];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"selectPlayer1"]) {
        selectPlayer1 = YES;
        selectPlayer2 = NO;
        SelectPlayerViewController *vc = [segue destinationViewController];
        [vc setDelegate:self];
        [vc setPlayers:players];
    }
    else if ([[segue identifier] isEqualToString:@"selectPlayer2"]) {
        selectPlayer1 = NO;
        selectPlayer2 = YES;
        SelectPlayerViewController *vc = [segue destinationViewController];
        [vc setDelegate:self];
        [vc setPlayers:players];
    }
    else if ([[segue identifier] isEqualToString:@"selectTeam1"]) {
        selectTeam1 = YES;
        selectTeam2 = NO;
        SelectTeamViewController *vc = [segue destinationViewController];
        [vc setDelegate:self];
    }
    else if ([[segue identifier] isEqualToString:@"selectTeam2"]) {
        selectTeam1 = NO;
        selectTeam2 = YES;
        SelectTeamViewController *vc = [segue destinationViewController];
        [vc setDelegate:self];
    }
}

- (IBAction)cancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePressed:(id)sender
{
    [SVProgressHUD show];
    [self saveGame:^(bool success) {
        if(success) {
            [SVProgressHUD showSuccessWithStatus:@"Great success!"];
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"Tables updated");
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"Could not save game, please try again."];
        }
    }];

}

-(void)saveGame:(void (^)(bool)) block{
    
    player1Updated = NO;
    player2Updated = NO;
    gameDataSaved = NO;
    failed = NO;
    
    PFObject *gameObject = [PFObject objectWithClassName:@"FifaGames"];
    [gameObject setObject:player1.name forKey:@"Player1Name"];
    [gameObject setObject:player2.name forKey:@"Player2Name"];
    
    [gameObject setObject:player1.objectId forKey:@"Player1Id"];
    [gameObject setObject:player2.objectId forKey:@"Player2Id"];
    
    [gameObject setObject:team1Index forKey:@"Player1TeamIndex"];
    [gameObject setObject:team2Index forKey:@"Player2TeamIndex"];
    
    [gameObject setObject:team1Score forKey:@"Player1Score"];
    [gameObject setObject:team2Score forKey:@"Player2Score"];
    
    [gameObject setObject:groupId forKey:@"GroupId"];
    
    [gameObject setObject:[[PFUser currentUser] objectForKey:@"fbId"] forKey:@"GameOwnerFbId"];
    
    [gameObject setObject:[NSNumber numberWithBool:NO] forKey:@"isArchived"];
    
    [gameObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            gameDataSaved = YES;
            if(player1Updated && player2Updated)
                block(YES);
        }
        else {
            if (!player1Updated && !player2Updated && !gameDataSaved) {
                if (!failed) {
                    failed = YES;
                    block(NO);
                }
            }
        }
    }];
    
    PFQuery *query = [PFQuery queryWithClassName:@"GroupToUser"];
    [query whereKey:@"fbId" equalTo:player1.fbId];
    [query whereKey:@"GroupId" equalTo:groupId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *player, NSError *error) {
        if (!error) {
            
            NSNumber *wins = [player valueForKey:@"Wins"];
            NSNumber *losses = [player valueForKey:@"Losses"];
            NSNumber *one = [NSNumber numberWithFloat:1];
            if ([losses floatValue] < 1) {
                losses = [NSNumber numberWithFloat:1];
            }
            
            // The get request succeeded. Log the score
            if ([team1Score compare:team2Score] == 1) {
                [player incrementKey:@"Wins"];
                wins = [NSNumber numberWithFloat:[wins floatValue] + [one floatValue]];
            }
            else if ([team1Score compare:team2Score] == -1) {
                [player incrementKey:@"Losses"];
                losses = [NSNumber numberWithFloat:[losses floatValue] + [one floatValue]];
            }
            else {
                [player incrementKey:@"Draws"];
            }
            NSNumber *wlr = [NSNumber numberWithFloat:([wins floatValue]/[losses floatValue])];
            [player setValue:wlr forKey:@"WLR"];
            NSLog(@"%@",[wlr stringValue]);
            [player save];
            player1Updated = YES;
            if(player2Updated && gameDataSaved) {
                block(YES);
            }
        } else {
            // Log details of our failure
            //[SVProgressHUD showErrorWithStatus:@"Could not save game, please try again."];
            NSLog(@"Error adding game: %@ %@", error, [error userInfo]);
            if (!player1Updated && !player2Updated && !gameDataSaved) {
                if (!failed) {
                    failed = YES;
                    block(NO);
                }
            }
        }
    }];
    PFQuery *query2 = [PFQuery queryWithClassName:@"GroupToUser"];
    [query2 whereKey:@"fbId" equalTo:player2.fbId];
    [query2 whereKey:@"GroupId" equalTo:groupId];
    [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *player, NSError *error) {
        if (!error) {
            
            NSNumber *wins = [player valueForKey:@"Wins"];
            NSNumber *losses = [player valueForKey:@"Losses"];
            NSNumber *one = [NSNumber numberWithFloat:1];
            if ([losses floatValue] < 1) {
                losses = [NSNumber numberWithFloat:1];
            }
            
            
            // The get request succeeded. Log the score
            if ([team1Score compare:team2Score] == -1) {
                [player incrementKey:@"Wins"];
                wins = [NSNumber numberWithFloat:[wins floatValue] + [one floatValue]];
            }
            else if ([team1Score compare:team2Score] == 1) {
                [player incrementKey:@"Losses"];
                losses = [NSNumber numberWithFloat:[losses floatValue] + [one floatValue]];
            }
            else {
                [player incrementKey:@"Draws"];
            }
            
            NSNumber *wlr = [NSNumber numberWithFloat:([wins floatValue]/[losses floatValue])];
            [player setValue:wlr forKey:@"WLR"];
            NSLog(@"%@",[wlr stringValue]);
            [player save];
            player2Updated = YES;
            if(player1Updated && gameDataSaved){
                block(YES);
            }
        } else {
            // Log details of our failure
            //[SVProgressHUD showErrorWithStatus:@"Could not save game, please try again."];
            NSLog(@"Error adding game: %@ %@", error, [error userInfo]);
            if (!player1Updated && !player2Updated && !gameDataSaved) {
                if (!failed) {
                    failed = YES;
                    block(NO);
                }
            }
        }
    }];
}


- (IBAction)changePlayer1Score:(id)sender
{
    int scoreValue = ((UIStepper *)sender).value;
    [player1ScoreLabel setText:[NSString stringWithFormat:@"%d", scoreValue]];
    team1Score = [NSNumber numberWithInt:scoreValue];
}

- (IBAction)changePlayer2Score:(id)sender
{
    int scoreValue = ((UIStepper *)sender).value;
    [player2ScoreLabel setText:[NSString stringWithFormat:@"%d", scoreValue]];
    team2Score = [NSNumber numberWithInt:scoreValue];
}

-(void) loadImagesToParse
{
    for (int i = 0; i < [[TeamData FifaTeams] teamInfoCount]; i++)
    {
        
        Team *team = [[TeamData FifaTeams] getTeamAtIndex:i];
        
        NSLog(@"team name is %@", team.name);
        
        PFQuery *query = [PFQuery queryWithClassName:@"FifaTeams"];
        [query whereKey:@"name" equalTo:team.name];
        PFObject *player = [query getFirstObject];
        NSLog(@"teamName %@", team.image);
        UIImage *image = [UIImage imageNamed:team.image];
        NSData *imageData = UIImagePNGRepresentation(image);
        
        PFFile *imageFile = [PFFile fileWithName:team.image data:imageData];
        [player setObject:imageFile forKey:@"logo"];
        [player setObject:team.image forKey:@"logoName"];
        [player saveInBackground];
        
    }
    
    NSLog(@"ALL DONE");

}
@end
