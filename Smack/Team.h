//
//  Team.h
//  FifaSmack
//
//  Created by Tarrence Van As on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *league;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSNumber *index;
-(void)setName:(NSString *)name;
- (id)initWithName:(id)aName andLeague:(id)aLeague andImage:(id)aImage andCountry:(id)country;


@end
