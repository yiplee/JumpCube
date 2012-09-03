//
//  stage5.m
//  jump
//
//  Created by yiplee  on 12-9-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "stage5.h"
#import "gameStaticData.h"

@implementation stage5

@synthesize floorHeight;
@synthesize stageLength;

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    stage5* stage = [stage5 node];
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
        stars = [[CCArray alloc] initWithCapacity:5];
        
        CGRect rect1 = CGRectMake(0, 0, 70, 10);
        int rect1HalfHeight = rect1.size.height*0.5;
        
        CGRect rect2 = CGRectMake(0, 0, 20, 15);
        int rect2HalfHeight = rect2.size.height*0.5;
        
        CGRect floorRect = CGRectMake(0, 0, stageLength, 10);
        int floorRectHalfHeight = floorRect.size.height*0.5;
        
        CCSprite* block0 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block0.position = CGPointMake(155, [self floorHeight]+rect1HalfHeight);
        [blocks insertObject:block0 atIndex:0];
        
        CCSprite* block1 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect2];
        block1.position = CGPointMake(size.width+rect2.size.width, [self floorHeight]+rect2HalfHeight);
        [blocks insertObject:block1 atIndex:1];
        
        CCSprite* floor = [CCSprite spriteWithFile:@"smallCube.png" rect:floorRect];
        floor.position = CGPointMake(size.width*0.5, floorHeight-floorRectHalfHeight);
        
        ccTexParams params =
        {
            GL_LINEAR,
            GL_LINEAR,
            GL_REPEAT,
            GL_REPEAT
        };
        [block0.texture setTexParameters:&params];
        [block1.texture setTexParameters:&params];
        [floor.texture setTexParameters:&params];
        
        CCSprite* star0 = [CCSprite spriteWithFile:@"mariostar.png"];
        star0.position = ccpAdd(block0.position,CGPointMake(0, 50));
        [stars insertObject:star0 atIndex:0];
        
        CCRotateBy* rotate = [CCRotateBy actionWithDuration:4 angle:-360];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:rotate];
        [star0 runAction:repeat];
        
        [self addChild:block0];
        [self addChild:block1];
        [self addChild:star0];
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
        [self checkStar];
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

- (void) checkStar
{
    for (int i=0;i<[stars count];i++)
    {
        CCSprite* _star = [stars objectAtIndex:i];
        if(_star.visible&&[hero checkHited:_star.boundingBox])
        {
            _star.visible = NO;
            
            CCParticleSystemQuad* starCrash = [CCParticleSystemQuad particleWithFile:@"starCrash.plist"];
            starCrash.positionType = kCCPositionTypeFree;
            starCrash.autoRemoveOnFinish = YES;
            starCrash.position = _star.position;
            [self addChild:starCrash];
            
            if (i == 0)
            {
                CCSprite* _block = [blocks objectAtIndex:1];
                CCMoveTo* move = [CCMoveTo actionWithDuration:0.8 position:CGPointMake(240, _block.position.y)];
                [_block runAction:move];
            }
        }
    }
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
    [self stopAllActions];
    [self unscheduleUpdate];
    [[[CCDirector sharedDirector] touchDispatcher] removeAllDelegates];
    [hero release];
    [blocks release];
    [stars release];
    blocks = nil;
    stars = nil;
    [super dealloc];
}


@end

