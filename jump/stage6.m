//
//  stage7.m
//  jump
//
//  Created by yiplee  on 12-9-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "stage6.h"
#import "gameStaticData.h"

@implementation stage6

@synthesize floorHeight;
@synthesize stageLength;

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    stage6* stage = [stage6 node];
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
        action1Done = NO;
        action2Done = NO;
        action3Done = NO;
        
        blocks = [[CCArray alloc] initWithCapacity:5];
        
        CGRect rect1 = CGRectMake(0, 0, 26, 20);
        int rect1HalfHeight = rect1.size.height*0.5;
        
        CGRect floorRect = CGRectMake(0, 0, stageLength, 10);
        
        CCSprite* block0 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block0.position = CGPointMake(195, size.height+rect1HalfHeight);
        [blocks insertObject:block0 atIndex:0];
        
        CCSprite* block1 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block1.position = CGPointMake(315, size.height+rect1HalfHeight);
        [blocks insertObject:block1 atIndex:1];
        
        CCSprite* block2 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block2.position = CGPointMake(440, size.height+rect1HalfHeight);
        [blocks insertObject:block2 atIndex:2];
        
        CCSprite* block3 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block3.anchorPoint = CGPointMake(0, 0);
        block3.position = CGPointMake(80, [self floorHeight]);
        [blocks insertObject:block3 atIndex:3];
        
        CCSprite* floor = [CCSprite spriteWithFile:@"smallCube.png" rect:floorRect];
        floor.position = CGPointMake(size.width*0.5, floorHeight-5);
        
        ccTexParams params =
        {
            GL_LINEAR,
            GL_LINEAR,
            GL_REPEAT,
            GL_REPEAT
        };
        
        [block0.texture setTexParameters:&params];
        [block1.texture setTexParameters:&params];
        [block2.texture setTexParameters:&params];
        [block3.texture setTexParameters:&params];
        [floor.texture setTexParameters:&params];
        
        [self addChild:block0];
        [self addChild:block1];
        [self addChild:block2];
        [self addChild:block3];
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
        [self updateBlock:delta];
        [self updateHero:delta];
    }
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
    CCSprite* _block;
    if (!action1Done)
    {
        if ([hero position].x >= 120)
        {
            _block = [blocks objectAtIndex:0];
            _block.anchorPoint = CGPointMake(0, 0);
            CCMoveTo* move = [CCMoveTo actionWithDuration:0.5 position:CGPointMake(_block.position.x, [self floorHeight])];
            [_block runAction:move];
            
            action1Done = YES;
        }
    }
    else if (!action2Done)
    {
        if ([hero position].x >= 240)
        {
            _block = [blocks objectAtIndex:1];
            _block.anchorPoint = CGPointMake(0, 0);
            CCMoveTo* move = [CCMoveTo actionWithDuration:0.5 position:CGPointMake(_block.position.x, [self floorHeight])];
            [_block runAction:move];
            
            action2Done = YES;
        }
    }
    else if (!action3Done)
    {
        if ([hero position].x >= 360)
        {
            _block = [blocks objectAtIndex:2];
            _block.anchorPoint = CGPointMake(0, -1);
            CCMoveTo* move = [CCMoveTo actionWithDuration:0.5 position:CGPointMake(_block.position.x, [self floorHeight])];
            [_block runAction:move];
            
            action3Done = YES;
        }
    }
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
    [self stopAllActions];
    [self unscheduleUpdate];
    [[[CCDirector sharedDirector] touchDispatcher] removeAllDelegates];
    [hero release];
    [blocks release];
    blocks = nil;
    [super dealloc];
}


@end
