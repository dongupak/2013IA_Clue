//
//  GameEnd.m
//  MonsterDead
//
//  Created by ivis01 on 13. 5. 6..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "GameEnd.h"


@implementation GameEnd
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameEnd *layer = [GameEnd node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        size = [[CCDirector sharedDirector] winSize];
        appD = (AppController *)[[UIApplication sharedApplication] delegate];
        sae = [SimpleAudioEngine sharedEngine];
        sae.effectsVolume = 0.9;
        
        p1 = [PlayerT1 shareP1];
        p2 = [PlayerT2 shareP2];
        p3 = [PlayerT3 shareP3];
        p4 = [PlayerT4 shareP4];
        
        if (appD.win == YES) {
            [sae playBackgroundMusic:@"bgSound_win.wav" loop:YES];
            CCSprite *bgsp = [CCSprite spriteWithFile:@"bg_win.jpg"];
            bgsp.position = ccp(size.width/2, size.height/2);
            [self addChild:bgsp];
            if (p1.seleted_player == 1)
                [self createPlayerFace:p1];
            else if (p2.seleted_player == 1) 
                [self createPlayerFace:p2];
            else if (p3.seleted_player == 1) 
                [self createPlayerFace:p3];
            else if (p4.seleted_player == 1)
                [self createPlayerFace:p4];
            
            NSString *scoreString = [NSString stringWithFormat:@"%d", appD.score];
            CCLabelTTF* scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"HUSunshower132" fontSize:60];
            scoreLabel.color = ccBLACK;
            scoreLabel.position = ccp(size.width*12/24, size.height*12/24);
            [self addChild:scoreLabel];
            
            
            CCLabelTTF* answerLabel = [CCLabelTTF labelWithString:@"정답" fontName:@"HUSunshower132" fontSize:40];
            answerLabel.color = ccBLACK;
            answerLabel.position = ccp(size.width*21/24, size.height*18/24);
            [self addChild:answerLabel];
            int a = 14;
            for (CCSprite* sp in appD.answerCards) {
                sp.position = ccp(size.width*21/24, size.height*a/24);
                sp.opacity = 255;
                if (sp.tag > 10) {
                    sp.scale = 0.25;
                }
                else {
                    sp.scale = 0.4;
                }
                [self addChild:sp];
                a -= 4;
            }
        }
        else {
            [sae playBackgroundMusic:@"bgSound_lose.mp3" loop:YES];
            [sae playEffect:@"effectSound_lose.wav"];
            CCSprite *bgsp = [CCSprite spriteWithFile:@"bg_lose.jpg"];
            bgsp.position = ccp(size.width/2, size.height/2);
            [self addChild:bgsp];
            
            
            CCLabelTTF* answerLabel = [CCLabelTTF labelWithString:@"정답" fontName:@"HUSunshower132" fontSize:40];
            answerLabel.color = ccBLACK;
            answerLabel.position = ccp(size.width*19/24, size.height*18/24);
            [self addChild:answerLabel];
            int a = 14;
            for (CCSprite* sp in appD.answerCards) {
                sp.position = ccp(size.width*19/24, size.height*a/24);
                sp.opacity = 255;
                if (sp.tag > 10) {
                    sp.scale = 0.25;
                }
                else {
                    sp.scale = 0.4;
                }
                [self addChild:sp];
                a -= 4;
            }
        }
        
        
        CCMenuItem* replay = [CCMenuItemImage itemWithNormalImage:@"btn_menu.png" selectedImage:@"btn_menu_s.png" target:self selector:@selector(doClick)];
        CCMenu* menu = [CCMenu menuWithItems:replay, nil];
        [self addChild:menu];
        menu.position = ccp(size.width / 2, size.height / 6);
        [menu alignItemsHorizontally];
    }
    return self;
}

-(void) createPlayerFace : (Player *) player {
    CCSprite *crown = [CCSprite spriteWithFile:@"crown.png"];
    crown.scale = 0.3;
    id crownTint = [CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, 10)],[CCMoveBy actionWithDuration:0.5 position:ccp(0, -10)], nil];
    [crown runAction:[CCRepeatForever actionWithAction:crownTint]];
    crown.position = ccp(size.width*4/24, size.height*14/24);
    player.playerFace.position = ccp(size.width*4/24, size.height*9/24);
    [self addChild:player.playerFace];
    [self addChild:crown];
}


-(void) doClick {
    [sae stopBackgroundMusic];
    [SceneManager goMenu];
}

@end
