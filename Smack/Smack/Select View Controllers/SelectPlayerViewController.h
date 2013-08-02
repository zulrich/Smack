//
//  SelectPlayerViewController.h
//  FifaSmack
//
//  Created by Zack Ulrich on 1/4/13.
//
//

#import <UIKit/UIKit.h>
#import "PlayerSelectCell.h"
#import "Player.h"

@class SelectPlayerViewController;

@protocol SelectPlayerViewControllerDelegate <NSObject>
- (void)playerPicker:(SelectPlayerViewController *)picker didPickPlayer:(Player *)playerName;
@end

@interface SelectPlayerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) id <SelectPlayerViewControllerDelegate> delegate;

@end
