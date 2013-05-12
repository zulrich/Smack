//
//  AddGameViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectTeamViewController.h"
#import "SelectPlayerViewController.h"
#import "Team.h"
#import "Teams.h"
#import "TeamData.h"
#import "Player.h"
#import "SVProgressHUD.h"
#import <Parse/Parse.h>

@interface AddGameViewController : UIViewController<SelectTeamViewControllerDelegate, SelectPlayerViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *player1ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *player2ImageView;

@property (strong, nonatomic) IBOutlet UIButton *team1Button;
@property (strong, nonatomic) IBOutlet UIButton *team2Button;
@property (strong, nonatomic) IBOutlet UIButton *player1Button;
@property (strong, nonatomic) IBOutlet UIButton *player2Button;

@property (strong, nonatomic) IBOutlet UILabel *player1ScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *player2ScoreLabel;
@property (nonatomic, strong) NSString *groupId;

@property (nonatomic, strong) Team *team1;
@property (nonatomic, strong) Team *team2;

@property (nonatomic, strong) Player *player1;
@property (nonatomic, strong) Player *player2;

@property NSNumber *team1Score;
@property NSNumber *team2Score;

@property NSNumber *team1Index;
@property NSNumber *team2Index;

@property (nonatomic, strong) NSMutableArray *players;


- (IBAction)cancelPressed:(id)sender;
- (IBAction)savePressed:(id)sender;
- (IBAction)changePlayer1Score:(id)sender;
- (IBAction)changePlayer2Score:(id)sender;



@end
