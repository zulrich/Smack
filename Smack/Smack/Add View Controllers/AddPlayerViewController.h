//
//  AddPlayerViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SVProgressHUD.h"
#import "Player.h"
#import "PlayerCell.h"

@class AddPlayerViewController;
@protocol AddPlayerDelegate <NSObject>

-(void) newPlayerAdded;

@end

@interface AddPlayerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, weak) id <AddPlayerDelegate> addPlayerDelegate;

- (IBAction)savePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *friendsTableView;



@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *groupName;

@end
