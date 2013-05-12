//
//  SelectTeamViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "SelectTeamViewController.h"

@interface SelectTeamViewController ()
{
    Teams *teams;
}


@end

@implementation SelectTeamViewController

@synthesize teamArray;
@synthesize filteredTeamArray;

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
    teams = [[Teams alloc] initArray];
    [teams sortAtoZ];

    teamArray = teams;
    filteredTeamArray = [NSMutableArray arrayWithCapacity:[teamArray count]];
    
    // Reload the table
    [[self teamTableView] reloadData];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredTeamArray count];
    }
	else
	{
        return [teamArray count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teamCell";
    TeamSelectCell *cell = [self.teamTableView
                            dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TeamSelectCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Team *team = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        team = [filteredTeamArray objectAtIndex:[indexPath row]];
    }
	else
	{
        team = [teamArray objectAtIndex:[indexPath row]];
    }
    
    //cell.nameLabel.text = @"test";
    
    cell.nameLabel.text = team.name;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Team *team = nil;
    NSNumber *teamIndex = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        team = [filteredTeamArray objectAtIndex:[indexPath row]];
        
    }
	else
	{
        team = [teamArray objectAtIndex:[indexPath row]];
    }
    teamIndex = team.index;
    
    //Team *team = [teams objectAtIndex:indexPath.row];
	[self.delegate teamPicker:self didPickTeamIndex:teamIndex didPickTeam:team];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredTeamArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    NSArray *tempArray = [teamArray filteredArrayUsingPredicate:predicate];
    
    filteredTeamArray = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


@end
