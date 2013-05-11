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

@interface PlayersViewController : UIViewController<UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) NSArray *players;
@property (strong, nonatomic) IBOutlet UITableView *playersTable;

-(void)reloadView;

@end
