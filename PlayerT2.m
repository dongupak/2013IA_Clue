//
//  PlayerT2.m
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 27..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "PlayerT2.h"

static PlayerT2 *shareP2 = nil;


@implementation PlayerT2

+(PlayerT2 *) shareP2 {
    if (shareP2 == nil) {
        shareP2 = [[super allocWithZone:NULL] init];
    }
    return  shareP2;
}

-(id)init
{
	if((self = [super init]))
	{
        // player 얼굴표시.
        self.myType = PLAYER_TYPE2;
        self.playerFace = [CCSprite spriteWithFile:@"p2_color.png"];
        self.havedCard = [CCArray new];
	}
	return self;
}

@end
