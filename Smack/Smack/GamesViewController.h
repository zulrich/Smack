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
#import "GameInfoViewController.h"

@class GamesViewController;

@protocol GamesViewDelegate <NSObject>

-(void)gameRemoved;

@end

@interface GamesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, GameInfoDelegate>

@property (weak, nonatomic) id <GamesViewDelegate> gameViewDelegate;

@property (nonatomic, strong) NSMutableArray *games;

@property (strong, nonatomic) IBOutlet UITableView *gamesTableView;
-(void)reloadView;


@end
