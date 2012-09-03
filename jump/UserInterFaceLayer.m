//
//  UserInterFaceLayer.m
//  jump
//
//  Created by yiplee  on 12-8-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInterFaceLayer.h"
#import "gameStaticData.h"
#import "SimpleAudioEngine.h"
#import "PauseMenu.h"

@implementation UserInterFaceLayer

@synthesize displayLife;
@synthesize displayStage;

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    UserInterFaceLayer* uiLayer = [UserInterFaceLayer node];
    [uiLayer addChild:scene];
    return scene;
}

- (id)init
{
    if (self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        lifeLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"BlockFont3.fnt"];
        lifeLabel.anchorPoint = CGPointMake(0, 1);
        lifeLabel.position = CGPointMake(5, size.height - 5);
        
        stageLabel = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"0/%i",[[gameStaticData sharedStaticData]totalStages]] fntFile:@"BlockFont3.fnt"];
        stageLabel.anchorPoint = CGPointMake(1, 1);
        stageLabel.position = CGPointMake(size.width-5, size.height-5);
        
        if ([[gameStaticData sharedStaticData]bgMusicOn])
        {
            mutelabel = [CCLabelBMFont labelWithString:@"MUTE" fntFile:@"BlockFont3.fnt"];
        }
        else
        {
            mutelabel = [CCLabelBMFont labelWithString:@"UNMUTE" fntFile:@"BlockFont3.fnt"];
        }
        mutelabel.anchorPoint = CGPointMake(1, 0);
        mutelabel.position = CGPointMake(size.width-5, 5);
        
        pauseLabel = [CCLabelBMFont labelWithString:@"PAUSE" fntFile:@"BlockFont3.fnt"];
        pauseLabel.anchorPoint = CGPointMake(0, 0);
        pauseLabel.position = CGPointMake(5, 5);
        
        [self addChild:lifeLabel];
        [self addChild:stageLabel];
        [self addChild:mutelabel];
        [self addChild:pauseLabel];
        [self setIsTouchEnabled:YES];
        [self scheduleUpdate];
    }
    return self;
}

- (void) update:(ccTime)delta
{
    int _life = [[gameStaticData sharedStaticData] life];
    if (displayLife != _life)
    {
        displayLife = _life;
        [lifeLabel setString:[NSString stringWithFormat:@"%i",displayLife]];
    }
    
    int _stage = [[gameStaticData sharedStaticData]currentStage];
    if (displayStage != _stage && _stage <= [[gameStaticData sharedStaticData]totalStages])
    {
        displayStage = _stage;
        [stageLabel setString:[NSString stringWithFormat:@"%i/%i",displayStage,[[gameStaticData sharedStaticData]totalStages]]];

    }
}

-(void) registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    if (CGRectContainsPoint(mutelabel.boundingBox, touchLocation))
    {
        [self muteButtonPressed];
        return YES;
    }
    else if (CGRectContainsPoint(pauseLabel.boundingBox, touchLocation))
    {
        [self pauseButtonPressed];
        return YES;
    }
    return NO;
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //do something
}

- (void) muteButtonPressed
{
    if ([[gameStaticData sharedStaticData] bgMusicOn])
    {
        [[gameStaticData sharedStaticData] setBgMusicOn:NO];
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        [mutelabel setString:@"UNMUTE"];
    }
    else
    {
        [[gameStaticData sharedStaticData] setBgMusicOn:YES];
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        [mutelabel setString:@"MUTE"];
    }
}

- (void) pauseButtonPressed
{
    if ([[gameStaticData sharedStaticData] bgMusicOn])
    {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    }
    [[CCDirector sharedDirector] pushScene:[PauseMenu scene]];
}

- (void) dealloc
{
    [[[CCDirector sharedDirector] touchDispatcher]removeAllDelegates];
    [super dealloc];
}

@end
