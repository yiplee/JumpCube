//
//  stage4.m
//  jump
//
//  Created by yiplee on 12-8-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "stage4.h"
#import "gameStaticData.h"

@implementation stage4

@synthesize floorHeight;
@synthesize stageLength;

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    stage4* stage = [stage4 node];
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
        
        blocks = [[CCArray alloc] initWithCapacity:5];
        
        CGRect rect1 = CGRectMake(0, 0, 26, 20);
        CGRect rect2 = CGRectMake(0, 0, 100, 20);
        CGRect floorRect = CGRectMake(0, 0, stageLength, 10);
        
        CCSprite* block1 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block1.position = CGPointMake(100, [self floorHeight]+10);
        [blocks addObject:block1];
        
        CCSprite* block2 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block2.position = CGPointMake(240, [self floorHeight]+10);
        [blocks addObject:block2];
        
        CCSprite* block3 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block3.position = CGPointMake(430, [self floorHeight]+10);
        [blocks addObject:block3];
        
        CCSprite* block4 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect2];
        block4.position = CGPointMake(335, [self floorHeight]+26);
        [blocks addObject:block4];
        
        CCSprite* floor = [CCSprite spriteWithFile:@"smallCube.png" rect:floorRect];
        floor.position = CGPointMake(size.width*0.5, floorHeight-5);
        
        ccTexParams params =
        {
            GL_LINEAR,
            GL_LINEAR,
            GL_REPEAT,
            GL_REPEAT
        };
        [block1.texture setTexParameters:&params];
        [block2.texture setTexParameters:&params];
        [block3.texture setTexParameters:&params];
        [block4.texture setTexParameters:&params];
        [floor.texture setTexParameters:&params];
        
        [self addChild:block1 z:0 tag:1];
        [self addChild:block2 z:1 tag:2];
        [self addChild:block3 z:2 tag:3];
        [self addChild:block4 z:3 tag:4];
        [self addChild:floor z:10 tag:10];
        
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
        [[gameStaticData sharedStaticData] oneMoreLife];
        
        CCParticleSystemQuad* cubeCrash = [CCParticleSystemQuad particleWithFile:@"square.plist"];
        cubeCrash.positionType = kCCPositionTypeFree;
        cubeCrash.autoRemoveOnFinish = YES;
        cubeCrash.position = [hero position];
        [self addChild:cubeCrash];
        [self resetHero];
    }
    
    else
    {
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
    //CCSprite* _block;
    for (CCSprite* _block in blocks)
    {
        if([hero checkHited:_block.boundingBox])
        {
            return YES;
        }
    }
    return NO;
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
    [blocks release];
    blocks = nil;
    [super dealloc];
}


@end

