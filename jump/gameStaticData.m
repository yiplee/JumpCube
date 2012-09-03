//
//  gameStaticData.m
//  jump
//
//  Created by yiplee  on 12-8-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "gameStaticData.h"
#import "MainMenuLayer.h"
#import "GameScene.h"
#import "Background.h"
#import "stage1.h"
#import "stage2.h"
#import "stage3.h"
#import "stage4.h"
#import "stage5.h"
#import "stage6.h"
#import "stage7.h"
#import "stage8.h"
#import "stage9.h"
#import "stage10.h"
#import "GameDone.h"

@implementation gameStaticData

@synthesize totalStages;
@synthesize currentStage;
@synthesize life;
@synthesize bgMusicOn;
@synthesize debugMode;
@synthesize level;

static gameStaticData* sharedStaticData = nil;

+ (gameStaticData*) sharedStaticData
{
    if (sharedStaticData == nil)
    {
        sharedStaticData = [[gameStaticData alloc] init];
    }
    return sharedStaticData;
}

- (id) init
{
    if (self = [super init])
    {
        [self setLevel:normalLevel];
        [self setDebugMode:NO];
        [self setBgMusicOn:YES];
        [self setCurrentStage:0];
        [self setLife:0];
        [self setTotalStages:10];
        
    }
    return self;
}

- (void) goToNext
{
    if ([self debugMode])
    {
        [self reset];
        [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
    }
    else
    {
        currentStage += 1;
        if (currentStage > totalStages)
        {
            [[CCDirector sharedDirector]replaceScene:[GameDone scene]];
        }
        else
        {
            [self enterStage:currentStage];
        }
    }
}

- (void) reset
{
    currentStage = 0;
    life = 0;
}

- (void) oneMoreLife
{
    life += 1;
}

- (void) enterStage: (int) _currentStage
{
    switch (_currentStage) {
        case 0:
            [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
            break;
        case 1:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage1 node]]];
            break;
        case 2:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage2 node]]];
            break;
        case 3:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage3 node]]];
            break;
        case 4:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage4 node]]];
            break;
        case 5:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage5 node]]];
            break;
        case 6:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage6 node]]];
            break;
        case 7:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage7 node]]];
            break;
        case 8:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage8 node]]];
            break;
        case 9:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage9 node]]];
            break;
        case 10:
            [[CCDirector sharedDirector]replaceScene:[GameScene scene:[stage10 node]]];
            break;
        default:
            [[CCDirector sharedDirector]replaceScene:[GameDone scene]];
            break;
    }
}

- (void) quitGame
{
    [[CCDirector sharedDirector] popScene];
    [self reset];
    [self enterStage:0];
}

- (void) dealloc
{
    [super dealloc];
}

@end
