//
//  MenuLayer.m
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "SceneManager.h"


@implementation MenuLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
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
        
        sae = [SimpleAudioEngine sharedEngine];
        [sae playBackgroundMusic:@"bgSound_menu.mp3" loop:YES];
		
		CCSprite *bgsp = [CCSprite spriteWithFile:@"bg.jpg"];
        bgsp.position = ccp(size.width/2, size.height/2);
        [self addChild:bgsp];
        
        CCLabelTTF *label_big = [CCLabelTTF labelWithString:@"훔쳤을까?" fontName:@"HUDdaku15" fontSize:85];
        label_big.color = ccBLACK;
        label_big.position = ccp(size.width/2, size.height*14/20);
        [self addChild:label_big];
        
        CCLabelTTF *label_who = [CCLabelTTF labelWithString:@"누가" fontName:@"HUSunshower132" fontSize:32];
        label_who.color = ccBLACK;
        label_who.rotation = -40;
        label_who.position = ccp(size.width*3/20, size.height*16/20);
        [self addChild:label_who];
        CCLabelTTF *label_what = [CCLabelTTF labelWithString:@"무엇을" fontName:@"HUSunshower132" fontSize:32];
        label_what.color = ccBLACK;
        label_what.rotation = -10;
        label_what.position = ccp(size.width*11/40, size.height*18/20);
        [self addChild:label_what];
        CCLabelTTF *label_where = [CCLabelTTF labelWithString:@"어디에서" fontName:@"HUSunshower132" fontSize:32];
        label_where.color = ccBLACK;
        label_where.rotation = 10;
        label_where.position = ccp(size.width*9/20, size.height*18/20);
        [self addChild:label_where];
        
        id whoUp = [CCMoveBy actionWithDuration:0.4 position:ccp(-5, 15)];
        id whoDown = [whoUp reverse];
        id whoAction = [CCSequence actions:whoUp, whoDown, [CCDelayTime actionWithDuration:1.6], nil];
        [label_who runAction:[CCRepeatForever actionWithAction:whoAction]];
        id whatUp = [CCMoveBy actionWithDuration:0.4 position:ccp(0, 15)];
        id whatDown = [whatUp reverse];
        id whatAction = [CCSequence actions:[CCDelayTime actionWithDuration:0.8], whatUp, whatDown,[CCDelayTime actionWithDuration:0.8],  nil];
        [label_what runAction:[CCRepeatForever actionWithAction:whatAction]];
        id whereUp = [CCMoveBy actionWithDuration:0.4 position:ccp(2, 15)];
        id whereDown = [whereUp reverse];
        id whereAction = [CCSequence actions:[CCDelayTime actionWithDuration:1.6], whereUp, whereDown, nil];
        [label_where runAction:[CCRepeatForever actionWithAction:whereAction]];
        
         CCMenuItemFont *gameLayer = [CCMenuItemFont itemWithString:@"start" target:self selector:@selector(goGameLayer)];
        gameLayer.fontName = @"CulDeSac";
        CCMenuItemFont *howtoLayer = [CCMenuItemFont itemWithString:@"how to" target:self selector:@selector(goHowtoLayer)];
        howtoLayer.fontName = @"CulDeSac";
        CCMenu *menu = [CCMenu menuWithItems:gameLayer, howtoLayer, nil];
        menu.color = ccBLACK;
        menu.position = ccp(size.width/2, size.height/4);
        [menu alignItemsVertically];
        [menu alignItemsVerticallyWithPadding:15];
        [self addChild:menu];
        
        
        CCMenuItem *creditIcon = [CCMenuItemImage itemWithNormalImage:@"btn_i.png" selectedImage:@"btn_i_s.png" target:self selector:@selector(goCreditLayer)];
        CCMenu *creditMenu = [CCMenu menuWithItems:creditIcon, nil];
        creditMenu.position = ccp(size.width/10, size.height/8);
        [self addChild:creditMenu];
        
    }
    return self;
}

-(void) goGameLayer {
    [sae stopBackgroundMusic];
    [SceneManager goGame];
}

-(void) goHowtoLayer {
    [sae stopBackgroundMusic];
    [SceneManager goHowto];
}

-(void) goCreditLayer {
    [sae stopBackgroundMusic];
    [SceneManager goCredit];
}

@end
