//
//  GroupCell.h
//  Smack
//
//  Created by Zack Ulrich on 7/26/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@interface GroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *groupImageView;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;

-(void) configureCell:(Group *)game;

@end
