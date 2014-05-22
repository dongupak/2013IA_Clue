//
//  Player.m
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize havedCard, turn, playerFace, myType, seleted_player;

-(id)init
{
	if((self = [super init]))
	{
        self.seleted_player = NO;
        self.turn = 10;
	}
	return self;
}

-(void) initialization{
    [self initialization_seleted_player];
    [self initialization_turn];
    [self.havedCard removeAllObjects];
}

-(void) initialization_seleted_player {
    self.seleted_player = NO;
}

-(void) initialization_turn{
    self.turn = 10;
}

@end
