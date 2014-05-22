//
//  PlayerT1.m
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "PlayerT1.h"

static PlayerT1 *shareP1 = nil;


@implementation PlayerT1

+(PlayerT1 *) shareP1 {
    if (shareP1 == nil) {
        shareP1 = [[super allocWithZone:NULL] init];
    }
    return  shareP1;
}

-(id)init
{
	if((self = [super init]))
	{
        // player 얼굴표시.
        self.myType = PLAYER_TYPE1;
        self.playerFace = [CCSprite spriteWithFile:@"p1_color.png"];
        self.havedCard = [CCArray new];
	}
	return self;
}

@end
