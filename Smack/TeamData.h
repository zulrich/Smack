//
//  TeamData.h
//  FifaSmack
//
//  Created by Zack Ulrich on 1/4/13.
//
//

#import <Foundation/Foundation.h>
#import "Team.h"

@interface TeamData : NSObject{
    
    NSMutableArray *images;
    NSMutableDictionary *imageDictionary;
    NSMutableArray *teamInfo;
    
    
}

-(NSData *)getImageForTeamName:(NSString *)name;
-(void) startLoading;

+(TeamData *)FifaTeams;

@end
