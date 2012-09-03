//
//  option.m
//  jump
//
//  Created by USTB on 12-8-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Option.h"
#import "gameStaticData.h"
#import "MainMenuLayer.h"

@implementation Option

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    Option* option = [Option node];
    [scene addChild:option];
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
        [self addChild:starNight z:0 tag:0];
        
        CCLabelBMFont* music = [CCLabelBMFont labelWithString:@"MUSIC:" fntFile:@"BlockFont3.fnt"];
        music.position = CGPointMake(size.width*0.5 - 70, size.height*0.75);
        [self addChild:music z:4];
        
        CCLabelBMFont* speed = [CCLabelBMFont labelWithString:@"SPEED:" fntFile:@"BlockFont3.fnt"];
        speed.position = CGPointMake(size.width*0.5 - 70, size.height*0.5);
        [self addChild:speed z:5];
        
        if ([[gameStaticData sharedStaticData] bgMusicOn])
            bgMusicOptionLabel = [CCLabelBMFont labelWithString:@"ON" fntFile:@"BlockFont3.fnt"];
        else
            bgMusicOptionLabel = [CCLabelBMFont labelWithString:@"OFF" fntFile:@"BlockFont3.fnt"];
        bgMusicOptionLabel.position= CGPointMake(size.width*0.5+65, size.height*0.75);
        [self addChild:bgMusicOptionLabel z:1 tag:1];
        
        if ([[gameStaticData sharedStaticData] level] == 1)
            gameLevelLabel = [CCLabelBMFont labelWithString:@"NORMAL" fntFile:@"BlockFont3.fnt"];
        else if ([[gameStaticData sharedStaticData] level] == 0)
            gameLevelLabel = [CCLabelBMFont labelWithString:@"SLOW" fntFile:@"BlockFont3.fnt"];
        else
            gameLevelLabel = [CCLabelBMFont labelWithString:@"FAST" fntFile:@"BlockFont3.fnt"];
        gameLevelLabel.position = CGPointMake(size.width*0.5+65, size.height*0.5);
        [self addChild:gameLevelLabel z:2 tag:2];
        
        backLabel = [CCLabelBMFont labelWithString:@"OK" fntFile:@"BlockFont3.fnt"];
        backLabel.position = CGPointMake(size.width*0.5+65, size.height*0.25);
        [self addChild:backLabel z:3 tag:3];
        
        [self setIsTouchEnabled:YES];
    }
    return self;
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1)
    {
        UITouch* touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInView: [touch view]];
        touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        if (CGRectContainsPoint(bgMusicOptionLabel.boundingBox, touchLocation))
            [self bgMusicOptionPressed];
        else if (CGRectContainsPoint(gameLevelLabel.boundingBox, touchLocation))
            [self gameLevelOptionPressed];
        else if (CGRectContainsPoint(backLabel.boundingBox, touchLocation))
            [self backPressed];
    }
}

- (void) bgMusicOptionPressed
{
    if ([[gameStaticData sharedStaticData] bgMusicOn])
    {
        [[gameStaticData sharedStaticData] setBgMusicOn:NO];
        [bgMusicOptionLabel setString:@"OFF"];
    }
    else
    {
        [[gameStaticData sharedStaticData] setBgMusicOn:YES];
        [bgMusicOptionLabel setString:@"ON"];

    }
}

- (void) gameLevelOptionPressed
{
    if ([[gameStaticData sharedStaticData] level] == 1)
    {
        [[gameStaticData sharedStaticData] setLevel:hardLevel];
        [gameLevelLabel setString:@"FAST"];
    }
    else if ([[gameStaticData sharedStaticData] level] == 2)
    {
        [[gameStaticData sharedStaticData] setLevel:easyLevel];
        [gameLevelLabel setString:@"SLOW"];
    }
    else
    {
        [[gameStaticData sharedStaticData] setLevel:normalLevel];
        [gameLevelLabel setString:@"NORMAL"];
    }
}

- (void) backPressed
{
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}

- (void) dealloc
{
    [super dealloc];
}

@end
