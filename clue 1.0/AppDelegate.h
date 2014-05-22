//
//  AppDelegate.h
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
    
    
    CCArray *answerCards;
    CCArray *cards;
    CCArray *selectedCards;
    NSInteger score;
    bool seletedTime_player;
    bool win;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;


@property (nonatomic, retain) CCArray *answerCards;
@property (nonatomic, retain) CCArray *cards;
@property (nonatomic, retain) CCArray *selectedCards;
@property NSInteger score;
@property bool seletedTime_player;
@property bool win;

@end
