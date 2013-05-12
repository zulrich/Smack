//
//  Teams.h
//  FifaSmack
//
//  Created by Tarrence Van As on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teams : NSMutableArray
@property (nonatomic, retain) NSMutableArray *teams;
//@property (nonatomic, readonly) NSUInteger count;

-(id)initArray;
-(NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
-(void)sortAtoZ;

@end
