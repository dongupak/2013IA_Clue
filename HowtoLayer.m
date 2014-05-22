//
//  HowtoLayer.m
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "HowtoLayer.h"
#import "SceneManager.h"


@implementation HowtoLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HowtoLayer *layer = [HowtoLayer node];
	
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
        size = [[CCDirector sharedDirector] winSize];
//		CCLabelTTF *label = [CCLabelTTF labelWithString:@"How to" fontName:@"Marker Felt" fontSize:64];
//		CGSize size = [[CCDirector sharedDirector] winSize];
//		label.position =  ccp( size.width /2 , size.height/2 );
//		[self addChild: label];
        
        howtoBg = [CCArray new];
        for (int a = 1; a <= 10; a++) {
            CCSprite *bg = [CCSprite spriteWithFile:[NSString stringWithFormat:@"bg_howto_%d.jpg", a]];
            bg.tag = a;
            [howtoBg addObject:bg];
        }
        
        bgsp = [howtoBg objectAtIndex:0];
        bgsp.position = ccp(size.width/2, size.height/2);
        [self addChild:bgsp];
        
        
        CCMenuItem *one = [CCMenuItemImage itemWithNormalImage:@"btn_firstPage.png" selectedImage:@"btn_firstPage_s.png" target:self selector:@selector(pageFirst)];
        one.scale = 0.6;
        CCMenuItem *next = [CCMenuItemImage itemWithNormalImage:@"btn_nextPage.png" selectedImage:@"btn_nextPage_s.png" target:self selector:@selector(pageNext)];
        CCMenuItem *before = [CCMenuItemImage itemWithNormalImage:@"btn_beforePage.png" selectedImage:@"btn_beforePage_s.png" target:self selector:@selector(pageBefore)];
        CCMenu *menu = [CCMenu menuWithItems:before, one, next, nil];
        [menu alignItemsHorizontally];
        [menu alignItemsHorizontallyWithPadding:20];
        menu.position = ccp(size.width/2, size.height/7);
        [self addChild:menu z:200];
        
        CCMenuItem *goBack = [CCMenuItemImage itemWithNormalImage:@"btn_menu.png" selectedImage:@"btn_menu_s.png" target:self selector:@selector(goBack)];
        CCMenu *returnMenu = [CCMenu menuWithItems:goBack, nil];
        returnMenu.scale = 0.8;
        returnMenu.position = ccp(size.width*8/10, size.height/11);
        [self addChild:returnMenu z:200];
        
    }
    return self;
}

-(void) pageFirst {
    NSLog(@"%d", bgsp.tag);
    [self removeChild:bgsp cleanup:YES];
    bgsp = [howtoBg objectAtIndex:0];
    bgsp.position = ccp(size.width/2, size.height/2);
    [self addChild:bgsp];
}

-(void) pageNext {
    NSLog(@"%d", bgsp.tag);
    [self removeChild:bgsp cleanup:YES];
    switch (bgsp.tag) {
        case 1:
            bgsp = [howtoBg objectAtIndex:1];
            break;
        case 2:
            bgsp = [howtoBg objectAtIndex:2];
            break;
        case 3:
            bgsp = [howtoBg objectAtIndex:3];
            break;
        case 4:
            bgsp = [howtoBg objectAtIndex:4];
            break;
        case 5:
            bgsp = [howtoBg objectAtIndex:5];
            break;
        case 6:
            bgsp = [howtoBg objectAtIndex:6];
            break;
        case 7:
            bgsp = [howtoBg objectAtIndex:7];
            break;
        case 8:
            bgsp = [howtoBg objectAtIndex:8];
            break;
        case 9:
            bgsp = [howtoBg objectAtIndex:9];
            break;
            
        default:
            bgsp = [howtoBg objectAtIndex:9];
            break;
    }
    bgsp.position = ccp(size.width/2, size.height/2);
    [self addChild:bgsp];
}

-(void) pageBefore {
    NSLog(@"%d", bgsp.tag);
    [self removeChild:bgsp cleanup:YES];
    switch (bgsp.tag) {
        case 2:
            bgsp = [howtoBg objectAtIndex:0];
            break;
        case 3:
            bgsp = [howtoBg objectAtIndex:1];
            break;
        case 4:
            bgsp = [howtoBg objectAtIndex:2];
            break;
        case 5:
            bgsp = [howtoBg objectAtIndex:3];
            break;
        case 6:
            bgsp = [howtoBg objectAtIndex:4];
            break;
        case 7:
            bgsp = [howtoBg objectAtIndex:5];
            break;
        case 8:
            bgsp = [howtoBg objectAtIndex:6];
            break;
        case 9:
            bgsp = [howtoBg objectAtIndex:7];
            break;
        case 10:
            bgsp = [howtoBg objectAtIndex:8];
            break;
            
        default:
            bgsp = [howtoBg objectAtIndex:0];
            break;
    }
    bgsp.position = ccp(size.width/2, size.height/2);
    [self addChild:bgsp];
}

-(void) goBack {
    [SceneManager goMenu];
}

@end
