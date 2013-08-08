//
//  TeamData.h
//  FifaSmack
//
//  Created by Zack Ulrich on 1/4/13.
//
//

#import <Foundation/Foundation.h>
#import "Team.h"
#import "enums.h"
//#import "Game.h"

@interface TeamData : NSObject{
    
    NSMutableDictionary *FifaImageDictionary;
    NSMutableArray *FifaTeamInfo;
    GameTypes selectedGameType;
    
    //NSMutableDictionary *NHLImageDictionary;
    //NSMutableArray *NHLTeamInfo;
    
    
}

-(NSString *) getTeamName:(NSUInteger)teamIndex;

-(NSData *)getImageForTeamName:(NSString *)name;
-(void) startLoadingWithGame:(GameTypes)activeGame;
- (id)getTeamAtIndex:(NSUInteger)index;
-(NSMutableArray *)getCopyTeamData;
-(NSUInteger)FIFAteamInfoCount;

//-(NSUInteger)NHLteamInfoCount;

+(TeamData *)FifaTeams;
//+(TeamData *)NHLTeams;

@end
