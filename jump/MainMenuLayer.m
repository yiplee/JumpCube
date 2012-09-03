//
//  MainMenuLayer.m
//  jump
//
//  Created by USTB on 12-8-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "MainMenu.h"
#import "Background.h"

@implementation MainMenuLayer

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    MainMenuLayer *mainMneuLayer = [MainMenuLayer node];
    [scene addChild:mainMneuLayer];
    return scene;
}

- (id) init
{
    if (self = [super init])
    {
        MainMenu* mainMenu = [MainMenu node];
        [self addChild:mainMenu z:1 tag:1];
        
        Background* background = [Background node];
        [self addChild:background z:2 tag:2];
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

@end
