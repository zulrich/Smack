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
        imageDictionary = [[NSMutableDictionary alloc] init];
        teamInfo = [[NSMutableArray alloc] init];
        [self loadTeamDataFromParse];
        
    }
    
    return self;
}
    
+(TeamData *)FifaTeams
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ { myTeamData = [[self alloc] init]; });
    return myTeamData;
}



-(void)retrieveImageFromParse:(NSString *)teamName
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
                [imageDictionary setObject:imageData forKey:teamName];
            }
        }

    
}
    
-(NSData *)getImageForTeamName:(NSString *)name
{
    
    if (![imageDictionary objectForKey:name])
    {
        
        [self retrieveImageFromParse:name];
        
    }
    
    return [imageDictionary objectForKey:name];
    
        
}

-(NSString *) getTeamName:(NSUInteger)teamIndex;
{
    Team *team = [teamInfo objectAtIndex:teamIndex];
    return team.teamName;
}

-(NSUInteger)teamInfoCount
{
    return [teamInfo count];
}

- (id)getTeamAtIndex:(NSUInteger)index
{
    //[self.team
    return [teamInfo objectAtIndex:index];
}




-(void)startLoading
{//used to init the fifa teams
    
}

-(void)loadTeamDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"FifaTeams"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.limit = 556;
    [SVProgressHUD showWithStatus:@"Loading Team Data"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error)
        {
            //NSLog(@"Successfully retrieved %d TESTING.", objects.count);
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
                
                    //NSLog(@"Queried image name is: %@ index is %d", teamName, i);
                    
                    Team *newTeam = [[Team alloc] initWithID:objID withteamName:teamName withLeague:league withCountry:country withSport:sport withLogo:logoName];
                    
                    [teamInfo addObject:newTeam];
                    
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
    NSMutableArray *returnArr = [[NSMutableArray alloc] initWithArray:teamInfo];
    return returnArr;
}
    
-(void)sortAtoZ
{
    NSComparator sortAscending = ^(Team *t1, Team *t2)
    {
        return [t1.teamName compare:t2.teamName];
    };
        
        [teamInfo sortUsingComparator:sortAscending];
        [self setIndexes];
}
    
-(void)setIndexes
{
    for (int i = 0; i < [teamInfo count]; i++)
    {
        [[teamInfo objectAtIndex:i] setIndex:[NSNumber numberWithInt:i]];
    }
}


@end
