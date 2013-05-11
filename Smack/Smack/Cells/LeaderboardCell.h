//
//  LeaderboardCell.h
//  FifaSmack
//
//  Created by Andrew Drozdov on 9/6/12.
//
//

#import <UIKit/UIKit.h>

@interface LeaderboardCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *rank;
@property (nonatomic, strong) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
@property (weak, nonatomic) IBOutlet UILabel *drawLabel;

@end
