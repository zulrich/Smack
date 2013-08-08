//
//  Group.m
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import "Group.h"

@implementation Group


-(id)initWithName:(NSString *)name withGroupID:(NSString *)groupID withObjectID:(NSString *)objectID withGameType:(GameTypes)gameType
{
    if (self = [super init])
    {

    
        self.groupName = name;
        self.groupID = groupID;
        self.objectID = objectID;
        self.gameType = gameType;
        
    }
    return self;
}
@end
