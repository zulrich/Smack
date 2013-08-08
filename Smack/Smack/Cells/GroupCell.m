//
//  GroupCell.m
//  Smack
//
//  Created by Zack Ulrich on 7/26/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell

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

-(void) configureCell:(Group *)group
{
    self.groupLabel.text = group.groupName;
    
    if (group.gameType == FIFA_GAME)
    {
        self.imageView.image = [UIImage imageNamed:@"soccer_ball (1)"];
    }
    
    else if(group.gameType == NHL_GAME)
    {
        self.imageView.image = [UIImage imageNamed:@"hockey"];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImage *image = [UIImage imageNamed:@"TableCellGradient"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:image];
    self.backgroundView = backgroundImageView;
}

@end
