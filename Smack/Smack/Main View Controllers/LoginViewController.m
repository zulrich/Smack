//
//  LoginViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/10/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

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
    //[self setTitle:@"Facebook Profile"];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        NSLog(@"We good");
        [self performSegueWithIdentifier:@"LoginSegue" sender:self];
    }
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
    // The permissions requested from the user
    NSArray *permissionsArray = nil;
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                if(error.code == 2)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet connections" message:@"Please make sure you have wifi or data connection" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
                    [alert show];
                
                }
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // Store the current user's Facebook ID on the user
                    [[PFUser currentUser] setObject:[result objectForKey:@"id"]
                                             forKey:@"fbId"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"name"]
                                             forKey:@"Name"];
                    
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    
                    dispatch_async(queue, ^{
                        
                        [[PFUser currentUser] save];
                    });
                    
                }
            }];
            
            
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];

            
        } else {
            NSLog(@"User with facebook logged in!");
            
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // Store the current user's Facebook ID on the user
                    [[PFUser currentUser] setObject:[result objectForKey:@"id"]
                                             forKey:@"fbId"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"name"]
                                             forKey:@"Name"];
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    
                    dispatch_async(queue, ^{
                        
                        [[PFUser currentUser] save];
                    });
                }
            }];
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];

           
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
