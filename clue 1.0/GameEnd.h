//
//  GameEnd.h
//  MonsterDead
//
//  Created by ivis01 on 13. 5. 6..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface GameEnd : CCLayer {
    CGSize size;
    AppController *appD;
    CCArray *allObjects;
    Player *p1;
    Player *p2;
    Player *p3;
    Player *p4;
    
    SimpleAudioEngine *sae;
}
+(CCScene *) scene;
@end
