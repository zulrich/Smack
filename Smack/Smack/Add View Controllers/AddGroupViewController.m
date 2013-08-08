//
//  AddGroupViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "AddGroupViewController.h"
#import "enums.h"

@interface AddGroupViewController ()
{
    PFObject *groupObject;
    UIPickerView *gameTypes;

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
    [self initializeGamePicker];
    [self.groupTextField becomeFirstResponder];
    
    gameTypesArray = [NSMutableArray arrayWithObjects:@"FIFA", @"NHL", nil];
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
    
    else if([gameTypeField.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"Please Select a Game Type"];
        return;
    }
    
    
    groupObject = [PFObject objectWithClassName:@"Group"];
    [groupObject setObject:self.groupTextField.text forKey:@"Name"];
    [groupObject setObject:[NSNumber numberWithInt:[self returnGameType:gameTypeField.text]] forKey:@"GameType"];
    [groupObject saveInBackgroundWithTarget:self
                                   selector:@selector(saveCallback:error:)];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(GameTypes)returnGameType:(NSString *)text
{
    if ([text isEqualToString:@"FIFA"])
    {
        return FIFA_GAME;
    }
    
    else if ([text isEqualToString:@"NHL"])
        return NHL_GAME;
    else
        return NULL_GAME;
}

- (void)saveCallback:(NSNumber *)result error:(NSError *)error
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^
    {
        if (!error) {
            // The groupObject saved successfully.
            PFObject *groupToPlayer =  [PFObject objectWithClassName:@"GroupToUser"];
            [groupToPlayer setObject:[groupObject objectId] forKey:@"GroupId"];
            [groupToPlayer setObject:[[PFUser currentUser] objectForKey:@"fbId"] forKey:@"fbId"];
            [groupToPlayer setObject:[[PFUser currentUser] objectForKey:@"Name"] forKey:@"Name"];
            [groupToPlayer setObject:[NSNumber numberWithInt:0] forKey:@"Wins"];
            [groupToPlayer setObject:[NSNumber numberWithInt:0] forKey:@"Losses"];
            [groupToPlayer setObject:[NSNumber numberWithInt:0] forKey:@"Draws"];
            [groupToPlayer setObject:[NSNumber numberWithInt:0] forKey:@"WLR"];
            [groupToPlayer setObject:self.groupTextField.text forKey:@"GroupName"];
            [groupToPlayer setObject:[NSNumber numberWithInt:[self returnGameType:gameTypeField.text]] forKey:@"GroupType"];
            [groupToPlayer save];
        } else {
            // There was an error saving the groupObject.
        }
    });
    

}

-(void)initializeGamePicker
{
    gameTypes = [[UIPickerView alloc] initWithFrame:CGRectZero];
    gameTypes.dataSource = self;
    gameTypes.delegate = self;
    gameTypes.showsSelectionIndicator = YES;
    
    //add toolbar to picker view with Done button
    UIToolbar *pickerAccessory = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerAccessory.barStyle = UIBarStyleBlackTranslucent;
    
    //space to the done buttton on right side
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //create done button and attach it to HideKeyboard method
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard)];
    pickerAccessory.items = @[space, done];
    
    //attach picker to the classroom name field
    gameTypeField.delegate = self;
    gameTypeField.inputView = gameTypes;
    gameTypeField.inputAccessoryView = pickerAccessory;
    
}

-(void) hideKeyboard
{
    [gameTypeField resignFirstResponder];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:gameTypeField.text forKey:@"lastClassRoomSelected"];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [gameTypesArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [gameTypesArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    gameTypeField.text = [gameTypesArray objectAtIndex:row];
}

@end
