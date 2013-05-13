//
//  GameInfoViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/12/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "TeamData.h"
#import "Team.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"

@class GameInfoViewController;
@protocol GameInfoDelegate <NSObject>

-(void)gameRemoved;

@end

@interface GameInfoViewController : UIViewController

@property (nonatomic, weak) id <GameInfoDelegate> gameInfoDelegate;

@property (nonatomic, strong) Game *selectedGame;

@property (strong, nonatomic) IBOutlet UIImageView *player1Image;
@property (strong, nonatomic) IBOutlet UIImageView *player2Image;

@property (strong, nonatomic) IBOutlet UILabel *player1ScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *player2ScoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *player1NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *player2NameLabel;

@property (strong, nonatomic) IBOutlet UILabel *player1TeamLabel;
@property (strong, nonatomic) IBOutlet UILabel *player2TeamLabel;


@property (strong, nonatomic) IBOutlet UIButton *deleteGameButton;
- (IBAction)deletePressed:(id)sender;

@end
