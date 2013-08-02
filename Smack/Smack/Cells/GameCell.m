//
//  GameCell.m
//  Smack
//
//  Created by Zack Ulrich on 7/26/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "GameCell.h"
#import "TeamData.h"

@implementation GameCell
@synthesize team2Image;
@synthesize team1Image;
@synthesize player1Name
,player1Score
,player2Name
,player2Score;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImage *image = [UIImage imageNamed:@"TableCellGradient"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:image];
    self.backgroundView = backgroundImageView;
}

-(void) configureCell:(Game *)game
{
    self.player1Name.text = game.player1Name;
    self.player2Name.text = game.player2Name;
    self.player1Score.text = [game.player1Score stringValue];
    self.player2Score.text = [game.player2Score stringValue];
    
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
       
                
        NSString *teamName = [[TeamData FifaTeams] getTeamName:[game.team1Index intValue]];
        
        UIImage *image1 =  [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:teamName]];
        teamName = [[TeamData FifaTeams] getTeamName:[game.team2Index intValue]];
        
        UIImage *image2 =  [UIImage imageWithData:[[TeamData FifaTeams] getImageForTeamName:teamName]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.team1Image.image = image1;
            self.team2Image.image = image2;
            ;
        });
        
    });
    
    
}



@end
