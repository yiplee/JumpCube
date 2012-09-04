//
//  GameDone.m
//  jump
//
//  Created by USTB on 12-8-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameDone.h"
#import "gameStaticData.h"
#import "MainMenuLayer.h"

@implementation GameDone


+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    GameDone* gameDone = [GameDone node];
    [scene addChild:gameDone];
    return scene;
}

- (id) init
{
    if (self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCParticleSystemQuad* starNight = [CCParticleSystemQuad particleWithFile:@"star.plist"];
        starNight.positionType = kCCPositionTypeFree;
        starNight.position = CGPointMake(size.width*0.5f, size.height);
        CCRotateBy* rotate = [CCRotateBy actionWithDuration:8.0f angle:360];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:rotate];
        [starNight runAction:repeat];
        [self addChild:starNight z:0 tag:0];
        
        CCLabelBMFont* congratulationLabel = [CCLabelBMFont labelWithString:@"Congratulations" fntFile:@"Shinjiblues2.fnt"];
        congratulationLabel.position = CGPointMake(size.width*0.5, size.height*0.75);
        
        CCLabelBMFont* deathLabel = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"DEATHS:%i",[[gameStaticData sharedStaticData] life]] fntFile:@"BlockFont3.fnt"];
        deathLabel.position = CGPointMake(size.width*0.5, size.height*0.5);
        //deathLabel.visible = NO;
        
        CCLabelBMFont* backLabel = [CCLabelBMFont labelWithString:@"MENU" fntFile:@"BlockFont3.fnt"];
        CCMenuItemLabel* backMenuButton = [CCMenuItemLabel itemWithLabel:backLabel target:self selector:@selector(backButtonTouched)];
        CCLabelBMFont* replayLabel = [CCLabelBMFont labelWithString:@"AGAIN?" fntFile:@"BlockFont3.fnt"];
        CCMenuItemLabel* replayButton = [CCMenuItemLabel itemWithLabel:replayLabel target:self selector:@selector(replayButtonTouched)];
        CCMenu* menu = [CCMenu menuWithItems:backMenuButton,replayButton, nil];
        menu.position = CGPointMake(size.width*0.5, size.height*0.2);
        [menu alignItemsHorizontallyWithPadding:60];
        //menu.visible = NO;
       
        
        [self addChild:congratulationLabel z:1 tag:1];
        [self addChild:deathLabel z:2 tag:2];
        [self addChild:menu z:3 tag:3];
    }
    return self;
}


- (void) backButtonTouched
{
    [[gameStaticData sharedStaticData]reset];
    [[CCDirector sharedDirector]replaceScene:[MainMenuLayer scene]];
}

- (void) replayButtonTouched
{
    [[gameStaticData sharedStaticData]reset];
    [[gameStaticData sharedStaticData]goToNext];
}

- (void) dealloc
{
    [self stopAllActions];
    [super dealloc];
}


@end
