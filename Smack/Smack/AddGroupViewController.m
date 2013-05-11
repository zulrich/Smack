//
//  AddGroupViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "AddGroupViewController.h"

@interface AddGroupViewController ()
{
    PFObject *groupObject;

}

@end

@implementation AddGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.groupTextField becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)donePressed:(id)sender
{
    if ([self.groupTextField.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"Please Enter a Group Name"];
        return;
    }
    
    
    groupObject = [PFObject objectWithClassName:@"Group"];
    [groupObject setObject:self.groupTextField.text forKey:@"Name"];
    [groupObject saveInBackgroundWithTarget:self
                                   selector:@selector(saveCallback:error:)];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveCallback:(NSNumber *)result error:(NSError *)error {
    if (!error) {
        // The groupObject saved successfully.
        NSLog(@"oid %@",[groupObject objectId]);
        PFObject *groupToPlayer =  [PFObject objectWithClassName:@"GroupToUser"];
        [groupToPlayer setObject:[groupObject objectId] forKey:@"GroupId"];
        NSLog(@"fbid: %@", [[[PFUser currentUser] objectForKey:@"fbId"] description ]);
        [groupToPlayer setObject:[[PFUser currentUser] objectForKey:@"fbId"] forKey:@"fbId"];
        [groupToPlayer setObject:[[PFUser currentUser] objectForKey:@"Name"] forKey:@"Name"];
        [groupToPlayer setObject:[NSNumber numberWithInt:0] forKey:@"Wins"];
        [groupToPlayer setObject:[NSNumber numberWithInt:0] forKey:@"Losses"];
        [groupToPlayer setObject:[NSNumber numberWithInt:0] forKey:@"Draws"];
        [groupToPlayer setObject:[NSNumber numberWithInt:0] forKey:@"WLR"];
        [groupToPlayer setObject:self.groupTextField.text forKey:@"GroupName"];
        [groupToPlayer save];
    } else {
        // There was an error saving the groupObject.
    }
}

@end
