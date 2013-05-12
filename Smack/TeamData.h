//
//  TeamData.h
//  FifaSmack
//
//  Created by Zack Ulrich on 1/4/13.
//
//

#import <Foundation/Foundation.h>

@interface TeamData : NSObject{
    
    NSMutableArray *images;
    NSMutableDictionary *imageDictionary;
    
    
}

-(NSData *)getImageForTeamName:(NSString *)name;
-(void) startLoading;

+(TeamData *)FifaTeams;

@end
