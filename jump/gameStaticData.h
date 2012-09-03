//
//  gameStaticData.h
//  jump
//
//  Created by yiplee  on 12-8-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum
{
    easyLevel = 0,
    normalLevel,
    hardLevel
}gameLevel;
@interface gameStaticData : NSObject
{
    int totalStages;
    int currentStage;
    int life;
    BOOL bgMusicOn;
    BOOL debugMode;
    gameLevel level;
}

@property int totalStages;
@property int currentStage;
@property int life;
@property BOOL bgMusicOn;
@property BOOL debugMode;
@property gameLevel level;

+ (gameStaticData*) sharedStaticData;

- (void) goToNext;

- (void) reset;

- (void) oneMoreLife;

- (void) enterStage: (int) _currentStage;

- (void) quitGame;

@end
