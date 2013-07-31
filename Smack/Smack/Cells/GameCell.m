//
//  GameCell.m
//  FifaSmack
//
//  Created by Andrew Drozdov on 9/6/12.
//
//

#import "GameCell.h"

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
    //if (self) {
        // Initialization code
        /*UIImageView *team1Icon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 45, 45)];
        team1Icon.image = [UIImage imageNamed:@"manSmall.png"];
        NSLog(@"in cell");
        [self addSubview:team1Icon];*/
    //}
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


@end
