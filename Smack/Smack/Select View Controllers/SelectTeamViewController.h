//
//  SelectTeamViewController.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamSelectCell.h"
#import "Team.h"
#import "TeamData.h"
@class SelectTeamViewController;

@protocol SelectTeamViewControllerDelegate <NSObject>
-(void)teamPicker:(SelectTeamViewController *)picker didPickTeamIndex:(NSNumber *)teamName didPickTeam:(Team *)theTeamObject;

@end


@interface SelectTeamViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, weak) id <SelectTeamViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITableView *teamTableView;

@property (strong, nonatomic) IBOutlet UISearchBar *teamSearchBar;

@end
