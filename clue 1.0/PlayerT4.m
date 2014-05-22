//
//  PlayerT4.m
//  clue 1.0
//
//  Created by ivis01 on 13. 6. 6..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "PlayerT4.h"


static PlayerT4 *shareP4 = nil;


@implementation PlayerT4

+(PlayerT4 *) shareP4 {
    if (shareP4 == nil) {
        shareP4 = [[super allocWithZone:NULL] init];
    }
    return  shareP4;
}

-(id)init
{
	if((self = [super init]))
	{
        // player 얼굴표시.
        self.myType = PLAYER_TYPE4;
        self.playerFace = [CCSprite spriteWithFile:@"p4_color.png"];
        self.havedCard = [CCArray new];
	}
	return self;
}

@end
