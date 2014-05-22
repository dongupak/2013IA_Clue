//
//  Player.h
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    PLAYER_TYPE1 = 204320,
    PLAYER_TYPE2,
    PLAYER_TYPE3,
    PLAYER_TYPE4,
} PLAYER_TYPE ;

@interface Player : CCSprite {
    
    CCSprite *playerFace;
    CCArray *havedCard;
    NSInteger myType;
    NSInteger turn;
    BOOL seleted_player;
}
@property (nonatomic, retain) CCSprite *playerFace;
@property (nonatomic, copy) CCArray *havedCard;
@property NSInteger turn;
@property NSInteger myType;
@property BOOL seleted_player;

-(void) initialization;
-(void) initialization_seleted_player;
-(void) initialization_turn;


@end
