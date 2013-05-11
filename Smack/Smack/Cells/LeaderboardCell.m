//
//  LeaderboardCell.m
//  FifaSmack
//
//  Created by Andrew Drozdov on 9/6/12.
//
//

#import "LeaderboardCell.h"

@implementation LeaderboardCell
@synthesize winLabel;
@synthesize loseLabel;
@synthesize drawLabel;
@synthesize rank
,name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
