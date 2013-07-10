//
//  Team.m
//  FifaSmack
//
//  Created by Tarrence Van As on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Team.h"

@implementation Team
@synthesize teamName;
@synthesize leagueName;
@synthesize logoName;
@synthesize countryName;
@synthesize index;
@synthesize sportName;
@synthesize objectID;


-(id)initWithID:(NSString *)objID withteamName:(NSString *)name withLeague:(NSString *)league
withCountry:(NSString *)country withSport:(NSString *)sport withLogo:(NSString *)logo
{
    self.objectID = objID;
    self.teamName = name;
    self.leagueName = league;
    self.countryName = country;
    self.logoName = logo;
    self.sportName = sport;
    
    
    return self;
}



@end
