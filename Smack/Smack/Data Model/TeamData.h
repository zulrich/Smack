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
    NSMutableDictionary *teamDictionary;
  //  NSMutableArray *gamesForGroup;
    
    
}

-(Team *) getTeamEntry:(NSString *)teamName;

-(NSData *)getImageForTeamName:(NSString *)name;
-(void) startLoading;
- (id)getTeamAtIndex:(NSUInteger)index;
-(NSMutableArray *)getCopyTeamData;
-(NSUInteger)teamInfoCount;
//-(NSString *)getTeamImageName:(NSString *)teamName;


//-(NSMutableArray *)getGames;
+(TeamData *)FifaTeams;

@end
