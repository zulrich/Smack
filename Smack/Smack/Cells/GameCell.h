//
//  GameCell.h
//  Smack
//
//  Created by Zack Ulrich on 7/26/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface GameCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *player1Name;
@property (nonatomic, strong) IBOutlet UILabel *player1Score;
@property (nonatomic, strong) IBOutlet UILabel *player2Name;
@property (nonatomic, strong) IBOutlet UILabel *player2Score;
@property (weak, nonatomic) IBOutlet UIImageView *team2Image;
@property (weak, nonatomic) IBOutlet UIImageView *team1Image;

-(void) configureCell:(Game *)game;

@end
