//
//  SmackTabViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayersViewController.h"
#import "AddPlayerViewController.h"
#import "Game.h"
#import "Player.h"

@interface SmackTabViewController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSMutableArray *games;

@end
