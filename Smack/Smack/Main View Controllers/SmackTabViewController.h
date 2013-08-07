//
//  SmackTabViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayersViewController.h"
#import "GamesViewController.h"
#import "LeaderboardViewController.h"
#import "AddPlayerViewController.h"
#import "AddGameViewController.h"
#import "Game.h"
#import "Player.h"
#import "TeamData.h"

@interface SmackTabViewController : UITabBarController<UITabBarControllerDelegate, AddGameDelegate, AddPlayerDelegate, GamesViewDelegate, PlayersViewDelegate>

@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSMutableArray *games;

@end
