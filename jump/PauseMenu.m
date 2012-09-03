//
//  PauseMenu.m
//  jump
//
//  Created by yiplee  on 12-9-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PauseMenu.h"
#import "gameStaticData.h"
#import "SimpleAudioEngine.h"

@implementation PauseMenu

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    PauseMenu* menu = [PauseMenu node];
    [scene addChild:menu];
    return scene;
}

- (id) init
{
    if (self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelBMFont* resumeLable = [CCLabelBMFont labelWithString:@"RESUME" fntFile:@"BlockFont3.fnt"];
        CCMenuItemLabel* resumeButton = [CCMenuItemLabel itemWithLabel:resumeLable target:self selector:@selector(resumeButtonPressed)];
        
        CCLabelBMFont* quitLabel = [CCLabelBMFont labelWithString:@"QUIT" fntFile:@"BlockFont3.fnt"];
        CCMenuItemLabel* quitButton = [CCMenuItemLabel itemWithLabel:quitLabel target:self selector:@selector(quitButtonPressed)];
        
        CCMenu* menu = [CCMenu menuWithItems:resumeButton,quitButton, nil];
        menu.position= CGPointMake(size.width*0.5, size.height*0.5);
        [menu alignItemsVerticallyWithPadding:40];
        [self addChild:menu];
    }
    return self;
}

- (void) resumeButtonPressed
{
    if ([[gameStaticData sharedStaticData] bgMusicOn])
    {
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    }
    [[CCDirector sharedDirector] popScene];
}

- (void) quitButtonPressed
{
    [[gameStaticData sharedStaticData] quitGame];
}

- (void) dealloc
{
    [super dealloc];
}

@end
