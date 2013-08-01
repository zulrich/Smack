//
//  GameCell.h
//  FifaSmack
//
//  Created by Andrew Drozdov on 9/6/12.
//
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
