//
//  GamesViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCell.h"
#import "Game.h"
#import "Team.h"
#import "TeamData.h"
#import "Teams.h"

@interface GamesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *games;
@property (nonatomic, retain) Teams *teams;

@property (strong, nonatomic) IBOutlet UITableView *gamesTableView;

@end
