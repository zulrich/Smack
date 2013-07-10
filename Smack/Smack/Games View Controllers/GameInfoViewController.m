//
//  GameInfoViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/12/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "GameInfoViewController.h"

@interface GameInfoViewController ()

@end

@implementation GameInfoViewController

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
    
    Team *team1 = [[TeamData FifaTeams] getTeamAtIndex:[self.selectedGame.team1Index intValue]];
    self.player1Image.image = [UIImage imageNamed:team1.logoName];    
    Team *team2 = [[TeamData FifaTeams] getTeamAtIndex:[self.selectedGame.team2Index intValue]];
    
    self.player2Image.image = [UIImage imageNamed:team2.logoName];

    self.player1ScoreLabel.text = [NSString stringWithFormat:@"%@", self.selectedGame.player1Score];
    
    self.player2ScoreLabel.text = [NSString stringWithFormat:@"%@", self.selectedGame.player2Score];
    
    self.player1NameLabel.text = self.selectedGame.player1Name;
    self.player2NameLabel.text = self.selectedGame.player2Name;
    
    self.player1TeamLabel.text = team1.teamName;
    self.player2TeamLabel.text = team2.teamName;
    
    if([[[PFUser currentUser] objectForKey:@"fbId"] isEqualToString: self.selectedGame.gameOwnerFbId])
    {
        //put back in to allow delete
        //self.deleteGameButton.hidden = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deletePressed:(id)sender
{
    [SVProgressHUD show];
    [self removeGame:^(bool success) {
        if(success) {
            [SVProgressHUD showSuccessWithStatus:@"Great success!"];

            //[self.gameInfoDelegate gameRemoved];
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"Tables updated");
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"Could not save game, please try again."];
        }
    }];
}

-(void)removeGame:(void (^)(bool)) block{
    
    PFQuery *removeGameQuery = [PFQuery queryWithClassName:@"FifaGames"];
    [removeGameQuery whereKey:@"objectId" equalTo:self.selectedGame.objectId];
    [removeGameQuery getFirstObjectInBackgroundWithBlock:^(PFObject *gameToRemove, NSError *error){
        
        [gameToRemove setObject:[NSNumber numberWithBool:YES] forKey:@"isArchived"];
        [gameToRemove save];
        block(YES);
        
    }];
    
    PFQuery *player1GroupToUserQuery = [PFQuery queryWithClassName:@"GroupToUser"];
    [player1GroupToUserQuery whereKey:@"objectId" equalTo:self.selectedGame.player1Id];
    [player1GroupToUserQuery getFirstObjectInBackgroundWithBlock:^(PFObject *player, NSError *error){
        
        if (!error){
            
            NSNumber *wins = [player valueForKey:@"Wins"];
            NSNumber *losses = [player valueForKey:@"Losses"];
            NSNumber *one = [NSNumber numberWithFloat:1];
            if ([losses floatValue] < 1) {
                losses = [NSNumber numberWithFloat:1];
            }
            
            if ([self.player1ScoreLabel.text compare:self.player2ScoreLabel.text] == 1) {
                [player incrementKey:@"Wins" byAmount: [NSNumber numberWithInt:-1]];
                wins = [NSNumber numberWithFloat:[wins floatValue] - [one floatValue]];
            }
            
            else if ([self.player1ScoreLabel.text compare:self.player2ScoreLabel.text] == -1) {
                [player incrementKey:@"Losses" byAmount: [NSNumber numberWithInt:-1]];
                losses = [NSNumber numberWithFloat:[losses floatValue] - [one floatValue]];
                
            }
            else{
                [player incrementKey:@"Draws" byAmount:[NSNumber numberWithInt:-1]];
            }
            
            NSNumber *wlr = [NSNumber numberWithFloat:([wins floatValue]/[losses floatValue])];
            [player setValue:wlr forKey:@"WLR"];
            [player save];
            
        } else {
            NSLog(@"Error game info view: %@ %@", error, [error userInfo]);
            block(NO);
        }
        
    }];
    
    PFQuery *player2GroupToUserQuery = [PFQuery queryWithClassName:@"GroupToUser"];
    [player2GroupToUserQuery whereKey:@"objectId" equalTo:self.selectedGame.player2Id];
    [player2GroupToUserQuery getFirstObjectInBackgroundWithBlock:^(PFObject *player, NSError *error){
        
        if (!error){
            
            NSNumber *wins = [player valueForKey:@"Wins"];
            NSNumber *losses = [player valueForKey:@"Losses"];
            NSNumber *one = [NSNumber numberWithFloat:1];
            
            if ([losses floatValue] < 1) {
                losses = [NSNumber numberWithFloat:1];
            }
            
            if ([self.player2ScoreLabel.text compare:self.player1ScoreLabel.text] == 1) {
                [player incrementKey:@"Wins" byAmount: [NSNumber numberWithInt:-1]];
                wins = [NSNumber numberWithFloat:[wins floatValue] - [one floatValue]];
                
            }
            
            else if ([self.player2ScoreLabel.text compare:self.player1ScoreLabel.text] == -1) {
                [player incrementKey:@"Losses" byAmount: [NSNumber numberWithInt:-1]];
                losses = [NSNumber numberWithFloat:[losses floatValue] - [one floatValue]];
                
                
            }
            else{
                [player incrementKey:@"Draws" byAmount:[NSNumber numberWithInt:-1]];
                
            }
            NSNumber *wlr = [NSNumber numberWithFloat:([wins floatValue]/[losses floatValue])];
            [player setValue:wlr forKey:@"WLR"];
            [player save];
            
        } else {
            // Log details of our failure
            //[SVProgressHUD showErrorWithStatus:@"Could not save game, please try again."];
            NSLog(@"Error game info view: %@ %@", error, [error userInfo]);
            block(NO);
        }
        
    }];
    
    
}

@end
