//
//  CreditLayer.m
//  clue 1.0
//
//  Created by ivis01 on 13. 6. 15..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "CreditLayer.h"


@implementation CreditLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreditLayer *layer = [CreditLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *bgsp = [CCSprite spriteWithFile:@"bg_credit.jpg"];
        bgsp.position = ccp(size.width/2, size.height/2);
        [self addChild:bgsp];
        
        
        CCMenuItem *goBack = [CCMenuItemImage itemWithNormalImage:@"btn_menu.png" selectedImage:@"btn_menu_s.png" target:self selector:@selector(goBack)];
        CCMenu *menu = [CCMenu menuWithItems:goBack, nil];
        goBack.scale = 0.8;
        menu.position = ccp(size.width*7/8, size.height/6);
        [self addChild:menu];
        
    }
    return self;
}

-(void) goBack {
    [SceneManager goMenu];
}

@end
