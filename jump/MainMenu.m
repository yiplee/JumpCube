//
//  MainMenu.m
//  jump
//
//  Created by USTB on 12-8-27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "Background.h"
#import "SimpleAudioEngine.h"
#import "GameScene.h"
#import "gameStaticData.h"
#import "About.h"
#import "option.h"

@implementation MainMenu

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    MainMenu *mainMenu = [MainMenu node];
    [scene addChild:mainMenu];
    return scene;
}

- (id) init
{
    if (self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelBMFont* gameTitle = [CCLabelBMFont labelWithString:@"Jump!Cube" fntFile:@"shinjiblues2.fnt"];
        gameTitle.position = ccp(size.width*0.5f, size.height*0.85f);
        [self addChild:gameTitle];
        
        CCLabelBMFont* Label01= [CCLabelBMFont labelWithString:@"START" fntFile:@"BlockFont3.fnt"];
        CCMenuItemLabel* startButton = [CCMenuItemLabel itemWithLabel:Label01 target:self selector:@selector(startGameButtonTouched)];
        
        CCLabelBMFont* Label02= [CCLabelBMFont labelWithString:@"ABOUT" fntFile:@"BlockFont3.fnt"];
        CCMenuItemLabel* aboutButton = [CCMenuItemLabel itemWithLabel:Label02 target:self selector:@selector(aboutButtonTouched)];
        
        //CCLabelBMFont* Label03= [CCLabelBMFont labelWithString:@"TEST" fntFile:@"BlockFont3.fnt"];
        //CCMenuItemLabel* testButton = [CCMenuItemLabel itemWithLabel:Label03 target:self selector:@selector(testButtonTouched)];
        
        CCLabelBMFont* label04 = [CCLabelBMFont labelWithString:@"OPTION" fntFile:@"BlockFont3.fnt"];
        CCMenuItemLabel* optionButton = [CCMenuItemLabel itemWithLabel:label04 target:self selector:@selector(optionButtonPressed)];
        
        CCMenu* mainMenu = [CCMenu menuWithItems:startButton,optionButton,aboutButton, nil];
        mainMenu.position = CGPointMake(size.width*0.5f, size.height*0.4f);
        [self addChild:mainMenu];
        
        [mainMenu alignItemsVerticallyWithPadding:20];

        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bgMusic.mp3"];
        [self preloadParticleEffects:@"square.plist"];
        [self preloadParticleEffects:@"huixing.plist"];
        [self preloadParticleEffects:@"starCrash.plist"];
    }
    
    return self;
}

- (void) preloadParticleEffects:(NSString*)particleFile
{
    [CCParticleSystemQuad particleWithFile:particleFile];
}

- (void) dealloc
{
    //[[SimpleAudioEngine sharedEngine] unloadEffect:@"bgMusic.mp3"];
    [super dealloc];
}

- (void) startGameButtonTouched
{
    if ([[gameStaticData sharedStaticData]bgMusicOn])
    {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgMusic.mp3" loop:YES];
    }
    [[gameStaticData sharedStaticData] setDebugMode:NO];
    [[gameStaticData sharedStaticData] setCurrentStage:0];
    [[gameStaticData sharedStaticData] goToNext];
}

- (void) aboutButtonTouched
{
    [[CCDirector sharedDirector] replaceScene:[About scene]];
}

- (void) optionButtonPressed
{
    [[CCDirector sharedDirector] replaceScene:[Option scene]];
}

- (void) testButtonTouched
{
    if ([[gameStaticData sharedStaticData]bgMusicOn])
    {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgMusic.mp3" loop:YES];
    }
    [[gameStaticData sharedStaticData] setDebugMode:YES];
    [[gameStaticData sharedStaticData] reset];
    [[gameStaticData sharedStaticData] setCurrentStage:10];
    [[gameStaticData sharedStaticData] enterStage:10];
}

@end
