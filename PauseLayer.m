//
//  PauseLayer.m
//  clue 1.0
//
//  Created by ivis01 on 13. 6. 5..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"


@implementation PauseLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PauseLayer *layer = [PauseLayer node];
	
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
		// ask director for the window size
		size = [[CCDirector sharedDirector] winSize];
        
        p1 = [PlayerT1 shareP1];
        p2 = [PlayerT2 shareP2];
        p3 = [PlayerT3 shareP3];
        p4 = [PlayerT4 shareP4];
        
        allObjects = [CCArray new];
        for (int a = 1; a <= 4; a++) {
            CCSprite *object = [CCSprite spriteWithFile:[NSString stringWithFormat:@"p%d_color.png",a]];
            object.tag = a;
            [allObjects addObject:object];
        }
        for (int a = 1; a <= 6; a++) {
            CCSprite *object = [CCSprite spriteWithFile:[NSString stringWithFormat:@"goods_%d.png",a]];
            object.tag = a+4;
            [allObjects addObject:object];;
        }
        for (int a = 1; a <= 6; a++) {
            CCSprite *object = [CCSprite spriteWithFile:[NSString stringWithFormat:@"place_%d.png",a]];
            object.tag = a+4+6;
            [allObjects addObject:object];
        }
        
        CCSprite *bgPause = [CCSprite spriteWithFile:@"bg_note.jpg"];
        bgPause.position = ccp(size.width/2, size.height/2);
        [self addChild:bgPause];
        
        [self createMenu];
        if (p1.seleted_player == 1) {
            [self createPlayerFace:p1];
            [self createPlayerHaved:p1];
            [self createPlayerTurn:p1];
        }
        else if (p2.seleted_player == 1) {
            [self createPlayerFace:p2];
            [self createPlayerHaved:p2];
            [self createPlayerTurn:p2];
        }
        else if (p3.seleted_player == 1) {
            [self createPlayerFace:p3];
            [self createPlayerHaved:p3];
            [self createPlayerTurn:p3];
        }
        else if (p4.seleted_player == 1) {
            [self createPlayerFace:p4];
            [self createPlayerHaved:p4];
            [self createPlayerTurn:p4];
        }
        
    }
    return self;
}

-(void) createMenu {
    CCMenuItem *resume = [CCMenuItemImage itemWithNormalImage:@"btn_back.png" selectedImage:@"btn_back_s.png" target:self selector:@selector(returnGame)];
    CCMenuItem *quit = [CCMenuItemImage itemWithNormalImage:@"btn_menu.png" selectedImage:@"btn_menu_s.png" target:self selector:@selector(goMenu)];
    CCMenu *menu = [CCMenu menuWithItems:resume, quit, nil];
    [menu alignItemsHorizontally];
    [menu alignItemsHorizontallyWithPadding:50];
    menu.position = ccp(size.width/2, size.height/5);
    [self addChild:menu];
}

-(void) createPlayerFace : (Player *) player {
    CCSprite *box = [CCSprite spriteWithFile:@"pause_playerBox.png"];
    box.position = ccp(size.width*4/24, size.height*18/24);
    player.playerFace.position = ccp(size.width*4/24, size.height*18/24);
    [self addChild:player.playerFace];
    [self addChild:box];
}

-(void) createPlayerTurn : (Player *) player {
    NSString* playerTurn = [NSString stringWithFormat:@"남은 턴 : %d", player.turn];
    CCLabelTTF *label = [CCLabelTTF labelWithString:playerTurn fontName:@"HoonWcatR" fontSize:40];
    label.color = ccBLACK;
    label.position = ccp(size.width*4/24, size.height*10/24);
    [self addChild:label];
}

-(void) createPlayerHaved : (Player *) player {
    CCLabelTTF *haveLabel = [CCLabelTTF labelWithString:@"이 알고 있는 것" fontName:@"HoonWcatR" fontSize:50];
    haveLabel.color = ccBLACK;
    haveLabel.rotation = -5;
    haveLabel.position = ccp(size.width*14/24, size.height*21/24);
    [self addChild:haveLabel];
    
    int num = 3; // 위치 지정 용
    for (CCSprite *ob in player.havedCard) {
        for (CCSprite *allOb in allObjects) {
            if (ob.tag == allOb.tag) {
                if (allOb.tag > 10) {
                    allOb.scale = 0.3;
                }
                else {
                    allOb.scale = 0.5;
                }
                allOb.position = ccp(size.width/7*num, size.height*16/24);
                [self addChild:allOb];
                num++;
            }
        }
        
    }
}

-(void) goMenu {
    [SceneManager goMenu];
}

-(void) returnGame {
    [[CCDirector sharedDirector] popScene];
}

@end
