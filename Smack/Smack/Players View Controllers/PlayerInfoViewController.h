//
//  PlayerInfoViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/12/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "TeamData.h"
#import "GameCell.h"
#import "Game.h"

@interface PlayerInfoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *playerRecordLabel;
@property (strong, nonatomic) IBOutlet UITableView *playerRecordTableView;

@property (nonatomic, strong) NSArray *games;
@property (nonatomic, strong) Player *selectedPlayer;

@end
