//
//  Group.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *groupName;

-(id)initWithName:(NSString *)name withID:(NSString *)groupID;



@end
