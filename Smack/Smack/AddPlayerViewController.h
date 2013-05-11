//
//  AddPlayerViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddPlayerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

- (IBAction)savePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *groupName;

@end
