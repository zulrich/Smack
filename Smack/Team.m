//
//  Team.m
//  FifaSmack
//
//  Created by Tarrence Van As on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Team.h"

@implementation Team
@synthesize name;
@synthesize league;
@synthesize image;
@synthesize country;
@synthesize index;

- (id)initWithName:(id)aName andLeague:(id)aLeague andImage:(id)aImage andCountry:(id)aCountry{

    name = aName;
    league = aLeague;
    image = aImage;
    country = aCountry;
    
    return self;
}

@end
