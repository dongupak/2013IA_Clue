//
//  PauseLayer.h
//  clue 1.0
//
//  Created by ivis01 on 13. 6. 5..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
#import "PlayerT1.h"
#import "PlayerT2.h"
#import "PlayerT3.h"
#import "PlayerT4.h"
#import "GameLayer.h"
#import "SceneManager.h"

@interface PauseLayer : CCLayer {
    CGSize size;
    Player *p1;
    Player *p2;
    Player *p3;
    Player *p4;
    
    CCArray *allObjects;
    
}
+(CCScene *) scene;

@end
