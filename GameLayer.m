//
//  GameLayer.m
//  clue 1.0
//
//  Created by ivis01 on 13. 5. 22..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "SceneManager.h"

#define playerNumber 4
#define goodsNumber 6
#define placeNumber 6

@implementation GameLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)]) ) {
        size = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        
        sae = [SimpleAudioEngine sharedEngine];
        sae.effectsVolume = 0.9;
        [sae playBackgroundMusic:@"bgSound_play.mp3" loop:YES];
        
        appD = (AppController *)[[UIApplication sharedApplication] delegate];
        
        p1 = [PlayerT1 shareP1];
        p2 = [PlayerT2 shareP2];
        p3 = [PlayerT3 shareP3];
        p4 = [PlayerT4 shareP4];
        
        [appD.selectedCards removeAllObjects];
        [appD.cards removeAllObjects];
        [appD.answerCards removeAllObjects];
        appD.score = 0;
        
        [self madeAllArray];
        [self madeAnsers];
        [self goProlog];
        
        score = 10000;
        [self schedule:@selector(timer) interval:0.1];
        
    }
    return self;
}

-(void) allRemove {
    [self removeAllChildrenWithCleanup:YES];
}

#pragma mark selectePlayer

-(void) prolog {
    id fadein = [CCFadeIn actionWithDuration:1.0];
    id fadeout = [CCFadeOut actionWithDuration:1.0];
    id move = [CCMoveBy actionWithDuration:8.0 position:ccp(0, 500)];
    
    NSString *prologString = [NSString stringWithFormat:@"친구 4명이서 놀고 있었다.\n놀던 중 누군가가 물건을 훔쳤다.\n범인을 잡으려고 하지만\n서로 말싸움만 할 뿐 해결되지 않았다.\n그래서 4명이서 추리를 하기로 했다.\n 이 4명 중,\n 우리들 물건 중에,\n 우리가 갔던 장소 중에\n알리바이가 없는 걸 찾아\n범인을 찾자고!\n모두 고개를 끄덕이며\n알리바이가 없는 걸 찾기로 했다."];
    CCLabelTTF* prologLabel = [CCLabelTTF labelWithString:prologString fontName:@"HUDdaku15" fontSize:38];
    prologLabel.color = ccBLACK;
    prologLabel.position = ccp(size.width/2, -size.height/3);
    [prologLabel runAction:[CCSequence actions:fadein, move, fadeout,[CCCallFuncN actionWithTarget:self selector:@selector(goSelP)], nil]];
    [self addChild:prologLabel];
    
    id leftR = [CCRotateTo actionWithDuration:0.3 angle:-10];
    id rightR = [CCRotateTo actionWithDuration:0.3 angle:10];
    CCMenuItemFont *skip = [CCMenuItemFont itemWithString:@"skip" target:self selector:@selector(goSelP)];
    [skip setFontName:@"CulDeSac"];
    CCMenu* dMenu = [CCMenu menuWithItems:skip, nil];
    [skip runAction:[CCRepeatForever actionWithAction:[CCSequence actions:leftR, rightR, nil]]];
    dMenu.color = ccRED;
    dMenu.position = ccp(size.width*9/10, size.height/10);
    [self addChild:dMenu];
}

// 플레이어 선택
-(void) seleteTime_player {
    id wrigglingly = [CCSequence actions:[CCRotateBy actionWithDuration:0.2 angle:10], [CCRotateBy actionWithDuration:0.2 angle:-10], nil];
    id seePlayer = [CCFadeIn actionWithDuration:1.0];
    p1.playerFace.position =ccp(size.width/5, size.height*4/5);
    [self addChild:p1.playerFace];
    [p1.playerFace runAction:seePlayer];
    p2.playerFace.position =ccp(size.width*4/5, size.height/5);
    [self addChild:p2.playerFace];
    [p2.playerFace runAction:[seePlayer copy]];
    p3.playerFace.position =ccp(size.width*4/5, size.height*4/5);
    [self addChild:p3.playerFace];
    [p3.playerFace runAction:[seePlayer copy]];
    p4.playerFace.position =ccp(size.width/5, size.height/5);
    [self addChild:p4.playerFace];
    [p4.playerFace runAction:[seePlayer copy]];
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"CHOOSE" fontName:@"HUDdaku15" fontSize:60];
    label.color = ccBLACK;
    label.position = ccp(size.width/2, size.height/2);
    [label runAction:[CCRepeatForever actionWithAction:wrigglingly]];
    [self addChild:label];
}

// player 선택 되묻기, 혹 다른 player 를 선택하고플 때 되돌아갈 수 있도록.
-(void) seleteTime_player_decide {
    id seePlayer = [CCFadeIn actionWithDuration:1.0];
    if (p1.seleted_player == 1) {
        p1.playerFace.position =ccp(size.width/3, size.height/2);
        [self addChild:p1.playerFace];
        [p1.playerFace runAction:seePlayer];
    }
    else if (p2.seleted_player == 1) {
        p2.playerFace.position =ccp(size.width/3, size.height/2);
        [self addChild:p2.playerFace];
        [p2.playerFace runAction:seePlayer];
    }
    else if (p3.seleted_player == 1) {
        p3.playerFace.position =ccp(size.width/3, size.height/2);
        [self addChild:p3.playerFace];
        [p3.playerFace runAction:seePlayer];
    }
    else if (p4.seleted_player == 1) {
        p4.playerFace.position =ccp(size.width/3, size.height/2);
        [self addChild:p4.playerFace];
        [p4.playerFace runAction:seePlayer];
    }
    CCMenuItem *OK = [CCMenuItemImage itemWithNormalImage:@"btn_ok.png" selectedImage:@"btn_ok_s.png" target:self selector:@selector(goOK)];
    CCMenuItem *reT = [CCMenuItemImage itemWithNormalImage:@"btn_back.png" selectedImage:@"btn_back_s.png"  target:self selector:@selector(goSelP)];
    CCMenu* dMenu = [CCMenu menuWithItems:OK, reT, nil];
    [dMenu alignItemsVertically];
    [dMenu alignItemsVerticallyWithPadding:20];
    dMenu.color = ccBLACK;
    dMenu.position = ccp(size.width*2/3, size.height/2);
    [self addChild:dMenu];
    [dMenu runAction:[seePlayer copy]];
}


// seletedTime_player 일 때 각 player 선택시 하는 동작
-(void) clickPlayerFace : (Player *) p {
    p.seleted_player = YES;
    [self removeAllChildrenWithCleanup:YES];
    [self seleteTime_player_decide];
}



#pragma mark createObject


-(void) timer {
    score -= 1;
    NSLog(@"%d", score);
    if (score == 0) {
        appD.win = NO;
        [self goEnd];
    }
    if (score <= 900 && score%160 == 0) {
        [sae playEffect:@"alam.wav"];
    }
    if (score == 900) {
        CCSprite *timerWatch = [CCSprite spriteWithFile:@"timer.png"];
        timerWatch.scale = 0.2;
        timerWatch.position = ccp(size.width/10, size.height*9/10);
        timerWatch.color = ccRED;
        [self addChild:timerWatch];
        id rotation = [CCSequence actions:[CCRotateBy actionWithDuration:0.1 angle:5],[CCRotateBy actionWithDuration:0.2 angle:-10],[CCRotateBy actionWithDuration:0.1 angle:5], nil];
        [timerWatch runAction:[CCRepeatForever actionWithAction:rotation]];
    }
}


// 모든 선택지를 배열에 넣는다.
-(void) madeAllArray {
    players = [CCArray new];
    for (int a = 1; a <= playerNumber; a++) {
        CCSprite *object = [CCSprite spriteWithFile:[NSString stringWithFormat:@"p%d_color.png",a]];
        object.tag = a;
        [appD.cards addObject:object];
        [players addObject:object];
    }
    goods = [CCArray new];
    for (int a = 1; a <= goodsNumber; a++) {
        CCSprite *object = [CCSprite spriteWithFile:[NSString stringWithFormat:@"goods_%d.png",a]];
        object.tag = a+playerNumber;
        [appD.cards addObject:object];
        [goods addObject:object];
    }
    places = [CCArray new];
    for (int a = 1; a <= placeNumber; a++) {
        CCSprite *object = [CCSprite spriteWithFile:[NSString stringWithFormat:@"place_%d.png",a]];
        object.tag = a+playerNumber+goodsNumber;
        [appD.cards addObject:object];
        [places addObject:object];
    }
}

-(NSInteger) objectPositionX:(NSInteger) tag {
    switch (tag % 2) {
        case 0:
            return size.width/4;
            break;
            
        default:
            return size.width*3/4;
            break;
    }
}
-(NSInteger) objectPositionY:(NSInteger) tag {
    switch (tag % 6) {
        case 1:
        case 2:
            return size.height*3/14;
            break;
        case 3:
        case 4:
            return size.height*11/14;
            break;
            
        default:
            return size.height/2;
            break;
    }
}

// objects 고를 때, 처음 동작
-(void) selecteTimes_seeObjects {
    
    
    for (CCSprite *sp in players) {
        id fadeIn = [CCFadeIn actionWithDuration:0.5];
        sp.position = ccp([self objectPositionX:sp.tag], [self objectPositionY:sp.tag]);
        sp.scale = 0.9;
        [sp runAction:fadeIn];
        //        sp.opacity = 255;
        [self addChild:sp];
    }
    for (CCSprite *sp in goods) {
        sp.position = ccp([self objectPositionX:sp.tag], [self objectPositionY:sp.tag]);
        sp.scale = 0.6;
        sp.opacity = 0;
        [self addChild:sp];
    }
    for (CCSprite *sp in places) {
        sp.position = ccp([self objectPositionX:sp.tag], [self objectPositionY:sp.tag]);
        sp.scale = 0.5;
        sp.opacity = 0;
        [self addChild:sp];
    }
    
    CCMenuItemFont *pause = [CCMenuItemImage itemWithNormalImage:@"btn_pause.png" selectedImage:@"btn_pause_s.png" target:self selector:@selector(goPause)];
    pause.scale = 0.5;
    CCMenu *pauseMenu = [CCMenu menuWithItems:pause, nil];
    pauseMenu.position =ccp(size.width/2, size.height*11/12);
    pauseMenu.color = ccBLACK;
    [self addChild:pauseMenu];
    
    who = [CCMenuItemFont itemWithString:@"who" target:self selector:@selector(changeLookedObjects:)];
    who.fontName = @"HUDdaku15";
    who.fontSize = 48;
    who.tag = 1010;
    what = [CCMenuItemFont itemWithString:@"what" target:self selector:@selector(changeLookedObjects:)];
    what.fontName = @"HUDdaku15";
    what.fontSize = 48;
    what.tag = 1011;
    where = [CCMenuItemFont itemWithString:@"where" target:self selector:@selector(changeLookedObjects:)];
    where.fontName = @"HUDdaku15";
    where.fontSize = 48;
    where.tag = 1012;
    CCMenu *menu2 = [CCMenu menuWithItems:who, what, where, nil];
    menu2.position = ccp(-size.width/2, size.height*3/5);
    id menuMove = [CCMoveTo actionWithDuration:0.5 position:ccp(size.width/2, size.height*3/5)];
    [menu2 runAction:menuMove];
    [menu2 alignItemsVertically];
    menu2.color = ccc3(0, 0, 0);
    [menu2 alignItemsVerticallyWithPadding:2];
    [self addChild:menu2];
    
    id twinkle = [CCSequence actions:[CCTintTo actionWithDuration:0.4 red:175 green:25 blue:0], [CCTintTo actionWithDuration:0.4 red:150 green:150 blue:150], nil];
    CCMenuItemFont *next = [CCMenuItemFont itemWithString:@"NEXT" target:self selector:@selector(goNext)];
    next.fontName = @"HUDdaku15";
    next.fontSize = 50;
    menu = [CCMenu menuWithItems:next, nil];
    [menu runAction:[CCRepeatForever actionWithAction:twinkle]];
    menu.position =ccp(size.width/2, size.height/6);
    [self addChild:menu];
    menu.color = ccc3(0, 0, 0);
    menu.isTouchEnabled = NO;
    menu.opacity = 0;
    
//    [self explaination:@"설명"];
}

-(void) selectedObjectsAction :(id) sender {
    id changeO = [CCFadeTo actionWithDuration:0.3 opacity:120];
    id changeO2 = [CCFadeTo actionWithDuration:0.3 opacity:255];
    id selectedAction = [CCSequence actions:changeO, changeO2, nil];
    CCSprite* ob = (CCSprite*) sender;
    for (CCSprite* selOb in appD.selectedCards) {
        if (ob.tag == selOb.tag) {
            [selOb runAction:[CCRepeatForever actionWithAction:selectedAction]];
        }
    }
}

-(void) changeLookedObjects:(id) sender {
    CCMenuItem *item = (CCMenuItem *) sender;
    if (item.tag == 1010) {
        for (CCSprite *sp in appD.cards) {
            id fadeOut = [CCFadeOut actionWithDuration:0.5];
            id fadeIn = [CCFadeIn actionWithDuration:0.5];
            if (sp.tag > 0 && sp.tag <= playerNumber) {
                [self selectedObjectsAction:sp];
                [sp runAction:fadeIn];
            }
            else {
                if (sp.opacity > 0) {
                    [sp stopAllActions];
                    [sp runAction:fadeOut];
                }
            }
        }
    }
    if (item.tag == 1011) {
        for (CCSprite *sp in appD.cards) {
            id fadeOut = [CCFadeOut actionWithDuration:0.5];
            id fadeIn = [CCFadeIn actionWithDuration:0.5];
            if (sp.tag > playerNumber && sp.tag <= playerNumber + goodsNumber) {
                [self selectedObjectsAction:sp];
                [sp runAction:fadeIn];
                
            }
            else {
                if (sp.opacity > 0) {
                    [sp stopAllActions];
                    [sp runAction:fadeOut];
                }
            }
        }
    }
    if (item.tag == 1012) {
        for (CCSprite *sp in appD.cards) {
            id fadeOut = [CCFadeOut actionWithDuration:0.5];
            id fadeIn = [CCFadeIn actionWithDuration:0.5];
            
            if (sp.tag > playerNumber+goodsNumber && sp.tag <= playerNumber + goodsNumber+placeNumber) {
                [self selectedObjectsAction:sp];
                [sp runAction:fadeIn];
            }
            else {
                if (sp.opacity > 0) {
                    [sp stopAllActions];
                    [sp runAction:fadeOut];
                }
            }
        }
    }
}

// AnswerCards, 각 player의 havedCard 생성
-(void) madeAnsers {
    CCArray *cardsCopy = [appD.cards copy];
    
    // player answer
    CCSprite *rd = [players randomObject];
    [cardsCopy removeObject:rd];
    [appD.answerCards addObject:rd];
    
    // goods answer
    rd = [goods randomObject];
    [cardsCopy removeObject:rd];
    [appD.answerCards addObject:rd];
    
    // place answer
    rd = [places randomObject];
    [cardsCopy removeObject:rd];
    [appD.answerCards addObject:rd];
    
    for (CCSprite *sp in cardsCopy) {
        CCSprite *ob = [cardsCopy randomObject];
        if (cardsCopy.count % 4 == 0) {
            [p1.havedCard addObject:ob];
        }
        else if (cardsCopy.count % 4 == 1) {
            [p2.havedCard addObject:ob];
        }
        else if (cardsCopy.count % 4 == 2) {
            [p3.havedCard addObject:ob];
        }
        else {
            [p4.havedCard addObject:ob];
        }
        [cardsCopy removeObject:ob];
    }
}


#pragma mark decideScene

// 선택한 게 맞는지 안 맞는지, 몇 턴 남았는지 보여주는 layer 생성
-(void) decided {
    decideLayer = [CCLayer node];
    
    [self addChild:decideLayer];
    
    [self decideAnswer:decideLayer];
}

// 정답인지 아닌지 판단, 틀릴 시 누가 알리바이를 가지고 있는지 보여줌.
-(void) decideAnswer:(CCLayer *) dLayer {
    int count = 0;
    NSString *playerTurn = nil;
    BOOL turnZero = NO;
    // 턴수 표시
    if (p1.seleted_player == YES) {
        playerTurn = [NSString stringWithFormat:@"남은 턴 : %d", p1.turn];
        if (p1.turn == 0) {
            turnZero = YES;
        }
    }
    else if (p2.seleted_player == YES) {
        playerTurn = [NSString stringWithFormat:@"남은 턴 : %d", p2.turn];
        if (p2.turn == 0) {
            turnZero = YES;
        }
    }
    else if (p3.seleted_player == YES) {
        playerTurn = [NSString stringWithFormat:@"남은 턴 : %d", p3.turn];
        if (p3.turn == 0) {
            turnZero = YES;
        }
    }
    else if (p4.seleted_player == YES) {
        playerTurn = [NSString stringWithFormat:@"남은 턴 : %d", p4.turn];
        if (p4.turn == 0) {
            turnZero = YES;
        }
    }
    CCLabelTTF *label = [CCLabelTTF labelWithString:playerTurn fontName:@"HoonWcatR" fontSize:50];
    label.color = ccBLACK;
    label.position = ccp(size.width/2, size.height*5/6);
    [dLayer addChild:label];
    
    
    // 3개 다 맞는지 판별.
    for (CCSprite *card in appD.answerCards) {
        for (CCSprite *selC in appD.selectedCards) {
            if (card == selC) {
                [appD.selectedCards removeObject:selC];
                count++;
            }
        }
    }
    
    // 정답일 시.
    if (count == 3) {
        appD.win = YES;
        NSLog(@"%d", score);
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], [CCCallFuncN actionWithTarget:self selector:@selector(goEnd)], nil]];
    }
    // turn = 0 일시
    else if (turnZero == YES) {
        appD.win = NO;
        [self whoIsHaved];
        NSLog(@"틀렸어.");
        NSLog(@"%d", score);
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], [CCCallFuncN actionWithTarget:self selector:@selector(goEnd)], nil]];
    }
    // 틀릴 시
    else {
        [self whoIsHaved];
        NSLog(@"틀렸어.");
        CCMenuItem* replay = [CCMenuItemFont itemWithString:@"Replay" target:self selector:@selector(replay)];
        CCMenu* dMenu = [CCMenu menuWithItems:replay, nil];
        [dLayer addChild:dMenu];
        dMenu.position = ccp(size.width / 2, size.height / 5);
        dMenu.color = ccBLACK;
        [dMenu alignItemsHorizontally];
    }
}




// 선택한 카드는 3개, 중복 선택이 되지 않도록.
// 선택 3개 완료시 완료 되었다는 창이 뜨게 한다.
-(void) selectCard :(CCSprite *) card {
    int selectedCount = 0;
    bool remove = NO;
    for (CCSprite *selectC in appD.selectedCards) {
        selectedCount += 1;
        if (selectC == card) {
            remove = YES;
            selectedCount -= 1;
            [selectC removeAllChildrenWithCleanup:YES];
            [appD.selectedCards removeObject:selectC];
            [selectC stopAllActions];
            selectC.opacity = 255;
            break;
        }
    }
    if (remove == NO && selectedCount < 3) {
        [appD.selectedCards addObject:card];
        selectedCount += 1;
    }
    
    if (selectedCount == 3) {
        menu.isTouchEnabled = YES;
        if (menu.opacity == 0) {
            [menu runAction:[CCFadeIn actionWithDuration:0.6]];
        }
        menu.opacity = 255;
    }
    if (selectedCount != 3) {
        menu.isTouchEnabled = NO;
        if (menu.opacity == 255) {
            [menu runAction:[CCFadeOut actionWithDuration:0.6]];
        }
        menu.opacity = 0;
    }
}

// 현재 선택한 카드가 누가 가지고 있는지 보여준다.
// 확인용
-(void) whoHavedCard : (CCSprite *) card {
    for (CCSprite *answerC in appD.answerCards) {
        if (card == answerC) {
            NSLog(@"gameLayer : 정답");
            break;
        }
    }
    for (CCSprite *pCard in p1.havedCard) {
        if (card == pCard) {
            NSLog(@"p1이 가지고 있어");
            break;
        }
    }
    for (CCSprite *pCard in p2.havedCard) {
        if (card == pCard) {
            NSLog(@"p2이 가지고 있어");
            break;
        }
    }
}


// 누가 가지고 있는지 찾는다.
-(void) whoIsHaved {
    BOOL knew = NO;
    for (CCSprite *sel_O in appD.selectedCards) {
        if (knew == 0 && p1.seleted_player == NO) {
            for (CCSprite *p1_O in p1.havedCard) {
                if (p1_O.tag == sel_O.tag) {
                    [self lookingPlayerHavedObject:p1 :sel_O];
                    knew = YES;
                    break;
                }
            }
        }
        if (knew == 0 && p2.seleted_player == NO) {
            for (CCSprite *p2_O in p2.havedCard) {
                if (p2_O.tag == sel_O.tag) {
                    [self lookingPlayerHavedObject:p2 :sel_O];
                    knew = YES;
                    break;
                }
            }
        }
        if (knew == 0 && p3.seleted_player == NO) {
            for (CCSprite *p3_O in p3.havedCard) {
                if (p3_O.tag == sel_O.tag) {
                    [self lookingPlayerHavedObject:p3 :sel_O];
                    knew = YES;
                    break;
                }
            }
        }
        if (knew == 0 && p4.seleted_player == NO) {
            for (CCSprite *p4_O in p4.havedCard) {
                if (p4_O.tag == sel_O.tag) {
                    [self lookingPlayerHavedObject:p2 :sel_O];
                    knew = YES;
                    break;
                }
            }
        }
    }
    if (knew == 0) {
        CCLabelTTF *no = [CCLabelTTF labelWithString:@"아무도 모르네..." fontName:@"HoonWcatR" fontSize:60];
        no.color = ccBLACK;
        no.position = ccp(size.width*6/12, size.height*7/12);
        [self addChild:no];
    }
    else {
        CCLabelTTF *ga = [CCLabelTTF labelWithString:@"가" fontName:@"HoonWcatR" fontSize:60];
        ga.color = ccBLACK;
        ga.position = ccp(size.width*4/12, size.height/2);
        CCLabelTTF *aliby = [CCLabelTTF labelWithString:@"알리바이를" fontName:@"HoonWcatR" fontSize:40];
        aliby.color = ccBLACK;
        aliby.position = ccp(size.width*9/12, size.height*7/12);
        CCLabelTTF *haved = [CCLabelTTF labelWithString:@"가지고 있어" fontName:@"HoonWcatR" fontSize:40];
        haved.color = ccBLACK;
        haved.position = ccp(size.width*9/12, size.height*5/12);
        [self addChild:ga];
        [self addChild:aliby];
        [self addChild:haved];
    }
}

-(void) lookingPlayerHavedObject : (Player *) player : (CCSprite *) selectedObj {
    id moveFace = [CCMoveTo actionWithDuration:0.6 position:ccp(size.width*2/12, size.height/2)];
    id moveObject = [CCMoveTo actionWithDuration:0.6 position:ccp(size.width*6/12, size.height/2)];
    player.playerFace.position = ccp(-size.width/3, size.height/2);
    selectedObj.position = ccp(-size.width*2/3, size.height/2);
    selectedObj.opacity = 255;
    [decideLayer addChild:selectedObj];
    [decideLayer addChild:player.playerFace];
    [player.playerFace runAction:moveFace];
    [selectedObj runAction:moveObject];
}


#pragma mark Touch

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint glLocation = [[CCDirector sharedDirector] convertToGL:location];
    
    if (appD.seletedTime_player == 1) {
        if (CGRectContainsPoint([p1.playerFace boundingBox], glLocation)) {
            [self clickPlayerFace:p1];
        }
        else if (CGRectContainsPoint([p2.playerFace boundingBox], glLocation)) {
            [self clickPlayerFace:p2];
        }
        else if (CGRectContainsPoint([p3.playerFace boundingBox], glLocation)) {
            [self clickPlayerFace:p3];
        }
        else if (CGRectContainsPoint([p4.playerFace boundingBox], glLocation)) {
            [self clickPlayerFace:p4];
        }
    }
    
    for (CCSprite *sprite in appD.cards)
    {
        if (sprite.opacity != 0 && CGRectContainsPoint([sprite boundingBox], glLocation)) {
            [sae playEffect:@"clue_clickSound.wav"];
            NSLog(@"touch");
            // check 표시 나오도록. 다른 object fadein 할 시 이녀석들은 fadeout 하지 않는다.
            // 왜 그런지 이해 필요, 찾도록.
            //            CCSprite *check = [CCSprite spriteWithFile:@"check.png"];
            //            check.scale = 0.7;
            //            check.position = ccp(sprite.contentSize.width/2, sprite.contentSize.height/2);
            //            [sprite addChild:check];
            
            [sprite runAction:[CCSequence actions:[CCScaleBy actionWithDuration:0.3 scale:1.25], [CCScaleBy actionWithDuration:0.3 scale:0.8], nil]];
            [self selectCard:sprite];
            [self whoHavedCard:sprite];
            [self selectedObjectsAction:sprite];
        }
    }
}



#pragma mark moveScene

-(void) goProlog {
    [self prolog];
}

-(void) goOK {
    appD.seletedTime_player = NO;
    [self allRemove];
    [self selecteTimes_seeObjects];
}


-(void) goSelP {
    appD.seletedTime_player = YES;
    p1.seleted_player = NO;
    p2.seleted_player = NO;
    p3.seleted_player = NO;
    p4.seleted_player = NO;
    [self allRemove];
    [self seleteTime_player];
}

-(void) goNext {
    [self allRemove];
    [self decided];
}

-(void) goEnd {
    [self allRemove];
    [self unscheduleAllSelectors];
    [sae stopBackgroundMusic];
    int turnPlusScore = 0;
    if (p1.seleted_player == YES) {
        turnPlusScore = p1.turn * 100;
    }
    if (p2.seleted_player == YES) {
        turnPlusScore = p2.turn * 100;
    }
    if (p3.seleted_player == YES) {
        turnPlusScore = p3.turn * 100;
    }
    if (p4.seleted_player == YES) {
        turnPlusScore = p4.turn * 100;
    }
    appD.score = score + turnPlusScore;
    [SceneManager goGameEnd];
}

-(void) replay {
    [self allRemove];
    [appD.selectedCards removeAllObjects];
    if (p1.seleted_player == YES) {
        p1.turn -= 1;
    }
    if (p2.seleted_player == YES) {
        p2.turn -= 1;
    }
    if (p3.seleted_player == YES) {
        p3.turn -= 1;
    }
    if (p4.seleted_player == YES) {
        p4.turn -= 1;
    }
    [self selecteTimes_seeObjects];
}

-(void) goPause {
    [[CCDirector sharedDirector] pushScene:[PauseLayer scene]];
}


@end
