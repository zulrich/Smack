//
//  AddGroupViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SVProgressHUD.h"

@interface AddGroupViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *groupTextField;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;

@end
