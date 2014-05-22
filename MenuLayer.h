//
//  MenuLayer.h
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface MenuLayer : CCLayer {
    SimpleAudioEngine *sae;
}
+(CCScene *) scene;

@end
