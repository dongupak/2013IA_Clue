//
//  PlayerT3.m
//  clue 1.0
//
//  Created by ivis01 on 13. 6. 6..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "PlayerT3.h"

static PlayerT3 *shareP3 = nil;


@implementation PlayerT3

+(PlayerT3 *) shareP3 {
    if (shareP3 == nil) {
        shareP3 = [[super allocWithZone:NULL] init];
    }
    return  shareP3;
}

-(id)init
{
	if((self = [super init]))
	{
        // player 얼굴표시.
        self.myType = PLAYER_TYPE3;
        self.playerFace = [CCSprite spriteWithFile:@"p3_color.png"];
        self.havedCard = [CCArray new];
	}
	return self;
}
@end
