//
//  Player.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *favoriteTeam;
@property (nonatomic, strong) NSString *fbId;
@property (nonatomic, strong) NSNumber *wins;
@property (nonatomic, strong) NSNumber *losses;
@property (nonatomic, strong) NSNumber *draws;
@property (nonatomic, strong) NSNumber *WLR;
@end
