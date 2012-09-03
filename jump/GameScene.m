//
//  GameScene4.m
//  jump
//
//  Created by yiplee  on 12-8-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "Background.h"
#import "UserInterFaceLayer.h"

@implementation GameScene



+ (CCScene*) scene:(CCLayer*) stage
{
    CCScene* scene = [CCScene node];
    GameScene* gameScene = [GameScene node];
    [gameScene addChild:stage z:2 tag:2];
    [scene addChild:gameScene];
    return scene;
}

- (id) init
{
    if (self = [super init])
    {
        Background* background = [Background node];
        [self addChild:background z:1 tag:1];
        
        UserInterFaceLayer* uiLayer = [UserInterFaceLayer node];
        [self addChild:uiLayer z:3 tag:3];
        
        //[self setIsTouchEnabled:YES];
    }
    return self;
}



- (void) dealloc
{
    [super dealloc];
}
@end
