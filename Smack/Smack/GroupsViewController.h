//
//  GroupsViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Group.h"
#import "SmackTabViewController.h"

@interface GroupsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *groups;
}

- (IBAction)logoutRequested:(id)sender;

@end
