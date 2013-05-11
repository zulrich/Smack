//
//  Game.h
//  Smack
//
//  Created by Zack Ulrich on 5/11/13.
//  Copyright (c) 2013 Zack Ulrich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *player1Id;
@property (nonatomic, strong) NSString *player1Name;
@property (nonatomic, strong) NSString *player1Team;
@property (nonatomic, strong) NSNumber *player1Score;
@property (nonatomic, strong) NSString *player2Id;
@property (nonatomic, strong) NSString *player2Name;
@property (nonatomic, strong) NSString *player2Team;
@property (nonatomic, strong) NSNumber *player2Score;
@property (nonatomic, retain) NSNumber *team1Index;
@property (nonatomic, retain) NSNumber *team2Index;
@property (nonatomic, retain) NSString *gameOwnerFbId;
@end

