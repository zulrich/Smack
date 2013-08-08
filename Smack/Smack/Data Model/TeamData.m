//
//  TeamData.m
//  FifaSmack
//
//  Created by Zack Ulrich on 1/4/13.
//
//

#import "TeamData.h"
#import "Parse/Parse.h"
#import "SVProgressHUD.h"


@implementation TeamData

static TeamData *myTeamData;
-(id)init
{
    if(self == [super init])
    {
        FifaImageDictionary = [[NSMutableDictionary alloc] init];
        FifaTeamInfo = [[NSMutableArray alloc] init];
        
        NSLog(@"active game %d", selectedGameType);
        
    }
    
    return self;
}
    
+(TeamData *)FifaTeams
{
    
    if (myTeamData == nil)
    {
        myTeamData = [[TeamData alloc] init];
    }
    return myTeamData;
}




-(void)retrieveFIFAImageFromParse:(NSString *)teamName
{
    PFQuery *query = [PFQuery queryWithClassName:@"FifaTeams"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.limit = 556;
    [query whereKey:@"name" equalTo:teamName];
    
    
        PFObject *obj = [query getFirstObject];
        if(obj!= nil)
        {
            PFFile *theFile = [obj objectForKey:@"logo"];
            NSData *imageData = [theFile getData];
            if(imageData != nil)
            {
                [FifaImageDictionary setObject:imageData forKey:teamName];
            }
        }

    
}

-(void)retrieveNHLImageFromParse:(NSString *)teamName
{
    PFQuery *query = [PFQuery queryWithClassName:@"NHLTeams"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.limit = 30;
    [query whereKey:@"teamName" equalTo:teamName];
    
    
    PFObject *obj = [query getFirstObject];
    if(obj!= nil)
    {
        PFFile *theFile = [obj objectForKey:@"logo"];
        NSData *imageData = [theFile getData];
        if(imageData != nil)
        {
            [FifaImageDictionary setObject:imageData forKey:teamName];
        }
    }
    
    
}

-(NSData *)getImageForTeamName:(NSString *)name
{
    NSLog(@"team name %@", name);
    
    if (![FifaImageDictionary objectForKey:name])
    {
        
        if (selectedGameType == FIFA_GAME)
        {
            [self retrieveFIFAImageFromParse:name];
        }
        
        else if(selectedGameType == NHL_GAME)
        {
            [self retrieveNHLImageFromParse:name];
        }
        
        
        
    }
    
    return [FifaImageDictionary objectForKey:name];
    
        
}

-(NSString *) getTeamName:(NSUInteger)teamIndex;
{
    Team *team = [FifaTeamInfo objectAtIndex:teamIndex];
    return team.teamName;
}

-(NSUInteger)FIFAteamInfoCount
{
    return [FifaTeamInfo count];
}


- (id)getTeamAtIndex:(NSUInteger)index
{
    //[self.team
    return [FifaTeamInfo objectAtIndex:index];
}




-(void) startLoadingWithGame:(GameTypes)activeGame;
{//used to init the fifa teams
    selectedGameType = activeGame;
    
    if(selectedGameType == FIFA_GAME)
    {
        [self loadFIFATeamDataFromParse];
    }
    else if(selectedGameType == NHL_GAME)
    {
        [self loadNHLTeamDataFromParse];
    }

}

-(void) loadNHLTeamDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"NHLTeams"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.limit = 30;
    
    [SVProgressHUD showWithStatus:@"Loading Team Data"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        
        if(!error)
        {
            NSLog(@"Successfully retrieved %d TESTING.", objects.count);
            
            for (int i = 0; i < [objects count]; i++)
            {
                PFObject *obj = [objects objectAtIndex:i];
                
                if(obj != nil)
                {
                    NSString *objID = obj.objectId;
                    NSString *league = [obj objectForKey:@"league"];
                    NSString *logoName = [obj objectForKey:@"logoName"];
                    NSString *teamName = [obj objectForKey:@"teamName"];
                    
                    Team *team = [[Team alloc] initWithID:objID withteamName:teamName withLeague:league withCountry:league withSport:@"Hockey" withLogo:logoName];
                    
                    NSLog(@"team name %@", teamName);
                    
                    [FifaTeamInfo addObject:team];
                }
            }
        }
        else {
            // The network was inaccessible and we have no cached data for
            // this query.
            NSLog(@"Error getting team data: %@ %@", error, [error userInfo]);
            [SVProgressHUD showErrorWithStatus:@"Team Images Load Error"];
        }
        [self sortAtoZ];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [SVProgressHUD showSuccessWithStatus:@"Done Enjoy"];
    }];
}

-(void)loadFIFATeamDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"FifaTeams"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.limit = 560;
    [SVProgressHUD showWithStatus:@"Loading Team Data"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error)
        {
            NSLog(@"Successfully retrieved %d TESTING.", objects.count);
            for (int i = 0; i < [objects count]; i++)
            {
                
                PFObject *obj = [objects objectAtIndex:i];
                if(obj!= nil)
                {
                    NSString *objID = [obj objectForKey:@"objectId"];
                    NSString *country = [obj objectForKey:@"country"];
                    NSString *league = [obj objectForKey:@"league"];
                    NSString *logoName = [obj objectForKey:@"logoName"];
                    NSString *teamName = [obj objectForKey:@"name"];
                    NSString *sport = [obj objectForKey:@"sport"];
                
                    NSLog(@"Queried image name is: %@ index is %d", teamName, i);
                    
                    Team *newTeam = [[Team alloc] initWithID:objID withteamName:teamName withLeague:league withCountry:country withSport:sport withLogo:logoName];
                    
                    [FifaTeamInfo addObject:newTeam];
                    
                }
                
            }
            
        } else {
            // The network was inaccessible and we have no cached data for
            // this query.
            NSLog(@"Error getting team data: %@ %@", error, [error userInfo]);
            [SVProgressHUD showErrorWithStatus:@"Team Images Load Error"];
        }
        [self sortAtoZ];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [SVProgressHUD showSuccessWithStatus:@"Done Enjoy"];
        
    }];
 
    
}

-(NSMutableArray *)getCopyTeamData
{
    NSMutableArray *returnArr = [[NSMutableArray alloc] initWithArray:FifaTeamInfo];
    return returnArr;
}
    
-(void)sortAtoZ
{
    NSComparator sortAscending = ^(Team *t1, Team *t2)
    {
        return [t1.teamName compare:t2.teamName];
    };
        
        [FifaTeamInfo sortUsingComparator:sortAscending];
        [self setIndexes];
}
    
-(void)setIndexes
{
    for (int i = 0; i < [FifaTeamInfo count]; i++)
    {
        [[FifaTeamInfo objectAtIndex:i] setIndex:[NSNumber numberWithInt:i]];
    }
}


@end
