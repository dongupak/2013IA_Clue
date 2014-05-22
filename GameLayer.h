//
//  GameLayer.h
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "Player.h"
#import "PlayerT1.h"
#import "PlayerT2.h"
#import "PlayerT3.h"
#import "PlayerT4.h"
#import "AppDelegate.h"
#import "PauseLayer.h"



@interface GameLayer : CCLayerColor {
    CGSize size;
    
    CCArray *players;
    CCArray *goods;
    CCArray *places;
    CCSprite *face;
    CCSprite *knewObject;
    
    CCMenuItemFont *who;
    CCMenuItemFont *what;
    CCMenuItemFont *where;
    
    Player *p1;
    Player *p2;
    Player *p3;
    Player *p4;
    CCMenu *menu;
    CCLayer *decideLayer;
    
    AppController *appD;
    SimpleAudioEngine *sae;
    
    NSInteger score;
}

//@property (nonatomic, retain) CCArray *answerCards;
@property (nonatomic, retain) CCArray *allObjects;
//@property (nonatomic, retain) CCArray *selectedCards;

+(CCScene *) scene;

@end
