//
//  stage10.m
//  jump
//
//  Created by yiplee  on 12-9-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "stage10.h"
#import "gameStaticData.h"

@implementation stage10
@synthesize floorHeight;
@synthesize stageLength;

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    stage10* stage = [stage10 node];
    [scene addChild:stage];
    return scene;
}

- (id) init
{
    if (self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector]winSize];
        
        [self setFloorHeight:80];
        [self setStageLength:size.width];
        
        bigStar = [CCSprite spriteWithFile:@"PowerStar.png"];
        bigStar.position = CGPointMake(size.width*0.5, floorHeight+40);
        
        //CCRotateTo* rotate1 = [CCRotateTo actionWithDuration:0.4 angle:15];
        //CCRotateTo* rotate2 = [CCRotateTo actionWithDuration:0.4 angle:-15];
        //CCSequence* seq = [CCSequence actions:rotate1,rotate2, nil];
        //CCRepeatForever* repeat = [CCRepeatForever actionWithAction:seq];
        //[bigStar runAction:repeat];
        
        CGRect floorRect = CGRectMake(0, 0, stageLength, 10);
        CCSprite* floor = [CCSprite spriteWithFile:@"smallCube.png" rect:floorRect];
        floor.position = CGPointMake(size.width*0.5, floorHeight-5);
        
        ccTexParams params =
        {
            GL_LINEAR,
            GL_LINEAR,
            GL_REPEAT,
            GL_REPEAT
        };
        [floor.texture setTexParameters:&params];
        
        [self addChild:bigStar];
        [self addChild:floor];
        
        hero = [Hero heroWithParentNode:self];
        CGSize _heroSize = [hero heroSize];
        
        [hero setDestinationX:stageLength+_heroSize.width/2];
        
        [hero setPosition:CGPointMake(-_heroSize.width*0.5, floorHeight+_heroSize.height*0.5)];
        [hero retain];
        
        [self scheduleUpdate];
        [self setIsTouchEnabled:YES];
    }
    return self;
}



- (void) update:(ccTime) delta
{
    
    if ([self checkPassed])
    {
        [hero stop];
        [self unscheduleUpdate];
        [[gameStaticData sharedStaticData] goToNext];
    }
    else if ([self checkCollision])
    {
        [[gameStaticData sharedStaticData]oneMoreLife];
        
        CCParticleSystemQuad* cubeCrash = [CCParticleSystemQuad particleWithFile:@"square.plist"];
        cubeCrash.positionType = kCCPositionTypeFree;
        cubeCrash.autoRemoveOnFinish = YES;
        cubeCrash.position = [hero position];
        [self addChild:cubeCrash];
        [self resetHero];
    }
    else
    {
        [self checkStar];
        [self updateHero:delta];
    }
    //update blocks
}

- (void) resetHero
{
    [hero stop];
    CGSize _heroSize = [hero heroSize];
    [hero setPosition:CGPointMake(-_heroSize.width*0.5f, floorHeight+_heroSize.height*0.5)];
}

- (BOOL) checkPassed
{
    if ([hero position].x >= stageLength) return YES;
    return NO;
}

- (BOOL) checkCollision
{
    return NO;
}

- (void) checkStar
{
    if ([hero checkHited:bigStar.boundingBox])
    {
        CCRotateBy* rotate = [CCRotateBy actionWithDuration:1 angle:360];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:rotate];
        CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:ccpAdd(bigStar.position, CGPointMake(0, 150))];
        CCCallFunc* func = [CCCallFunc actionWithTarget:self selector:@selector(starMoveDone)];
        CCSequence* seq = [CCSequence actions:move,func, nil];
        [bigStar runAction:seq];
        [bigStar runAction:repeat];
    }
}

- (void) starMoveDone
{
    [bigStar stopAllActions];
    bigStar.visible = NO;
    CCParticleSystemQuad* starCrash = [CCParticleSystemQuad particleWithFile:@"starCrash.plist"];
    starCrash.positionType = kCCPositionTypeFree;
    starCrash.autoRemoveOnFinish = YES;
    starCrash.position = bigStar.position;
    [self addChild:starCrash];
}

- (void) updateHero:(ccTime) delta
{
    if ([hero jumpTimes] == 0)
    {
        [hero run:delta];
    }
}

- (void) updateBlock:(ccTime) delta
{
    //do something
}

-(void) registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [hero jump];
    return YES;
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //do something
}

- (void) dealloc
{
    [self unscheduleUpdate];
    [[[CCDirector sharedDirector] touchDispatcher] removeAllDelegates];
    [hero release];
    [super dealloc];
}

@end
