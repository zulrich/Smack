//
//  Team.h
//  FifaSmack
//
//  Created by Tarrence Van As on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject
@property (nonatomic, retain) NSString *objectID;
@property (nonatomic, retain) NSString *teamName;
@property (nonatomic, retain) NSString *leagueName;
@property (nonatomic, retain) NSString *logoName;
@property (nonatomic, retain) NSString *countryName;
@property (nonatomic, retain) NSNumber *index;
@property (nonatomic, retain) NSString *sportName;

-(id)initWithID:(NSString *)objID withteamName:(NSString *)name withLeague:(NSString *)league
    withCountry:(NSString *)country withSport:(NSString *)sport withLogo:(NSString *)logo;


@end
