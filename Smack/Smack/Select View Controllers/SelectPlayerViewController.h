//
//  SelectPlayerViewController.h
//  FifaSmack
//
//  Created by Tarrence Van As on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerSelectCell.h"
#import "Player.h"
//#import "PullRefreshTableViewController.h"

@class SelectPlayerViewController;

@protocol SelectPlayerViewControllerDelegate <NSObject>
- (void)playerPicker:(SelectPlayerViewController *)picker didPickPlayer:(Player *)playerName;
@end

@interface SelectPlayerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) id <SelectPlayerViewControllerDelegate> delegate;

@end
