//
//  SmackTabViewController.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "SmackTabViewController.h"

@interface SmackTabViewController ()

@end

@implementation SmackTabViewController

@synthesize groupID;
@synthesize groupName;
@synthesize players;
@synthesize games;

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
    self.delegate = self;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self refresh];
}

-(void)refreshCallback:(NSNotification *)notification{
    NSLog(@"RefreshCallback");
}

-(void)refresh{
    PFQuery *queryForPlayers = [PFQuery queryWithClassName:@"GroupToUser"];
    [queryForPlayers whereKey:@"GroupId" equalTo:self.groupID];
    queryForPlayers.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [queryForPlayers findObjectsInBackgroundWithBlock:^(NSArray *playerObjects, NSError *error) {
        NSMutableArray *playersTemp = [[NSMutableArray alloc] init];
        for (PFObject *player in playerObjects) {
            Player *tempPlayer = [[Player alloc] init];
            tempPlayer.name = [player objectForKey:@"Name"];
            tempPlayer.objectId = player.objectId;
            tempPlayer.wins = [player objectForKey:@"Wins"];
            tempPlayer.losses = [player objectForKey:@"Losses"];
            tempPlayer.draws = [player objectForKey:@"Draws"];
            tempPlayer.WLR = [player objectForKey:@"WLR"];
            tempPlayer.fbId = [player objectForKey:@"fbId"];
            [playersTemp addObject:tempPlayer];

        }
        self.players = playersTemp;
        [self updatePlayers];
        NSLog(@"updated players");
    }];
    
    PFQuery *queryForGames = [PFQuery queryWithClassName:@"Game"];
    [queryForGames whereKey:@"GroupId" equalTo:self.groupID];
    queryForGames.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [queryForGames orderByDescending:@"updatedAt"];
    [queryForGames findObjectsInBackgroundWithBlock:^(NSArray *playerObjects, NSError *error) {
        NSMutableArray *gamesTemp = [[NSMutableArray alloc] init];
        for (PFObject *player in playerObjects) { //player is really a game
            //Game *tempGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.managedObjectContext];
            if([[player objectForKey:@"isArchived"] isEqualToNumber:[NSNumber numberWithBool:NO]]){
                Game *tempGame = [[Game alloc] init];
                tempGame.objectId = player.objectId;
                tempGame.player1Name = [player objectForKey:@"Player1Name"];
                tempGame.player1Id = [player objectForKey:@"Player1Id"];
                tempGame.player1Team = [player objectForKey:@"Player1Team"];
                tempGame.player1Score = [player objectForKey:@"Player1Score"];
                tempGame.player2Name = [player objectForKey:@"Player2Name"];
                tempGame.player2Id = [player objectForKey:@"Player2Id"];
                tempGame.player2Team = [player objectForKey:@"Player2Team"];
                tempGame.player2Score = [player objectForKey:@"Player2Score"];
                tempGame.team1Index = [player objectForKey:@"Player1TeamIndex"];
                tempGame.team2Index = [player objectForKey:@"Player2TeamIndex"];
                tempGame.gameOwnerFbId = [player objectForKey:@"GameOwnerFbId"];
                [gamesTemp addObject:tempGame];
            }
        }
        self.games = [[NSMutableArray alloc] initWithArray:gamesTemp];
        [self updateGames];
        NSLog(@"updated games");
    }];
}

-(void)updatePlayers{
    for (UIViewController *vc in self.viewControllers)  {
        if([vc isKindOfClass:[PlayersViewController class]])
        {
            ((PlayersViewController*)vc).players = self.players;
            [((PlayersViewController*)vc) reloadView];
        }
//        else if([vc isKindOfClass:[GameViewController class]])
//        {
//        }
//        else if([vc isKindOfClass:[LeaderboardViewController class]])
//        {
//            ((LeaderboardViewController*)vc).players = self.players;
//            [((LeaderboardViewController*)vc) reloadView];
//        }
    }
}

-(void)updateGames{
    for (UIViewController *vc in self.viewControllers)  {
//        if([vc isKindOfClass:[PlayersViewController class]])
//        {
//            ((GameViewController*)vc).games = self.games;
//            [((GameViewController*)vc) reloadView];
//        }
//        else if([vc isKindOfClass:[GameViewController class]])
//        {
//            ((GameViewController*)vc).games = self.games;
//            [((GameViewController*)vc) reloadView];
//        }
//        else if([vc isKindOfClass:[LeaderboardViewController class]])
//        {
//            ((GameViewController*)vc).games = self.games;
//            [((GameViewController*)vc) reloadView];
//            
//        }
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    /*if ([segue.identifier isEqualToString:@"gameSelect"]) {
     UINavigationController *navigationController = segue.destinationViewController;
     SnapGameDetailViewController *controller = (SnapGameDetailViewController *)navigationController.topViewController;
     controller.delegate = self;
     controller.gameToShow = gameToShow;
     }*/
    
    if ([[segue identifier] isEqualToString:@"addGame"]) {
//        UINavigationController *navigationController = segue.destinationViewController;
//        AddGameViewController *vc = (AddGameViewController*)navigationController.topViewController;
//        vc.groupId = groupId;
//        [vc setPlayers:players];
        
    }
    else if ([[segue identifier] isEqualToString:@"addPlayerSegue"]) {
        
        AddPlayerViewController *vc = (AddPlayerViewController*)segue.destinationViewController;
        vc.groupID = self.groupID;
        vc.groupName = self.groupName;
    }
}

#pragma mark - UITabBarControllerDelegate
-(void)addGameSegue
{
    [self performSegueWithIdentifier:@"addGame" sender:self];
}
-(void)addPlayerSegue
{
    [self performSegueWithIdentifier:@"addPlayerSegue" sender:self];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    if([viewController isKindOfClass:[PlayersViewController class]])
    {
        
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Add Player" style:UIBarButtonItemStylePlain target:self action:@selector(addPlayerSegue)];
        self.navigationItem.rightBarButtonItem = button;
        
    }
//    else if([viewController isKindOfClass:[GameViewController class]])
//    {
//        
//        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Add Game" style:UIBarButtonItemStylePlain target:self action:@selector(addGameSegue)];
//        self.navigationItem.rightBarButtonItem = button;
//        
//        
//        
//    }
//    else if([viewController isKindOfClass:[LeaderboardViewController class]])
//    {
//        self.navigationItem.rightBarButtonItem = nil;
//    }
}

@end
