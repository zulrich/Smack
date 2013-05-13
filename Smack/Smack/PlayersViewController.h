//
//  PlayersViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerCell.h"
#import "Player.h"
#import "PlayerInfoViewController.h"

@interface PlayersViewController : UIViewController<UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) NSArray *games;
@property (strong, nonatomic) IBOutlet UITableView *playersTable;

-(void)reloadView;

@end
