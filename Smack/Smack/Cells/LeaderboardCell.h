//
//  LeaderboarCell.h
//  Smack
//
//  Created by Zack Ulrich on 7/26/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderboardCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *rank;
@property (nonatomic, strong) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
@property (weak, nonatomic) IBOutlet UILabel *drawLabel;

@end
