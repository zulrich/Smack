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

-(NSData *)getImageForTeamName:(NSString *)name
{
    return [imageDictionary objectForKey:name];
}

-(void)startLoading
{
    
}
-(void)loadTeamDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"FifaTeams"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
//    [query whereKey:@"name" equalTo:@""];
    query.limit = 25;
    NSLog(@"IN cache %d", [query hasCachedResult]);
    [SVProgressHUD showWithStatus:@"Loading Team Data"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error)
        {
            NSLog(@"Successfully retrieved %d TESTING.", objects.count);
            for (int i = 0; i < [objects count]; i++)
            {
                
                PFObject *obj = [objects objectAtIndex:i];
                if(obj!= nil)
                {
                    NSString *imageName = [obj objectForKey:@"name"];
                    NSLog(@"Queried image name is: %@ index is %d", imageName, i);                    
                    PFFile *theFile = [obj objectForKey:@"logo"];
                    NSData *imageData = [theFile getData];
                    if(imageData != nil)
                    {
//                        NSLog(@"Added name: %@ , at index: %d", imageName, i);
                        [imageDictionary setObject:imageData forKey:imageName];
                    }
                }
                
            }
            
        } else {
            // The network was inaccessible and we have no cached data for
            // this query.
            NSLog(@"Error getting team data: %@ %@", error, [error userInfo]);
            [SVProgressHUD showErrorWithStatus:@"Team Images Load Error"];
        }
        [SVProgressHUD showSuccessWithStatus:@"Done Enjoy"];
        
    }];
    
    
}

@end
