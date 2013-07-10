//
//  LeaderboardViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/12/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "LeaderboardCell.h"
#import "PlayerInfoViewController.h"
#import "Player.h"

@interface LeaderboardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *leaderboardTableView;

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSMutableArray *games;
-(void)reloadView;
@end
