//
//  TeamData.h
//  FifaSmack
//
//  Created by Zack Ulrich on 1/4/13.
//
//

#import <Foundation/Foundation.h>
#import "Team.h"
//#import "Game.h"

@interface TeamData : NSObject{
    
    NSMutableArray *images;
    NSMutableDictionary *imageDictionary;
    NSMutableArray *teamInfo;
  //  NSMutableArray *gamesForGroup;
    
    
}

-(NSData *)getImageForTeamName:(NSString *)name;
-(void) startLoading;
- (id)getTeamAtIndex:(NSUInteger)index;
-(NSMutableArray *)getCopyTeamData;
-(NSUInteger)teamInfoCount;
//-(void)loadGames:(NSString *)groupID;
//-(void)addGame:(NSString *)groupID;

-(NSMutableArray *)getGames;
+(TeamData *)FifaTeams;

@end
