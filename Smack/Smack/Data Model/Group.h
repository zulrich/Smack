//
//  Group.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "enums.h"

@interface Group : NSObject

@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic) GameTypes gameType;

-(id)initWithName:(NSString *)name withGroupID:(NSString *)groupID
     withObjectID:(NSString *)objectID withGameType:(GameTypes)gameType;



@end
