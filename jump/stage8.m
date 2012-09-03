//
//  stage8.m
//  jump
//
//  Created by yiplee  on 12-9-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "stage8.h"
#import "gameStaticData.h"

@implementation stage8

@synthesize floorHeight;
@synthesize stageLength;

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    stage8* stage = [stage8 node];
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
        
        CGRect rect1 = CGRectMake(0, 0, 20, 20);
        CGRect rect2 = CGRectMake(0, 0, 50, 20);
        CGRect rect3 = CGRectMake(0, 0, 20, 50);
        
        CGRect floorRect = CGRectMake(0, 0, [self stageLength], 10);
        int floorRectHalfHeight = floorRect.size.height*0.5;
        
        //block0
        CCSprite* block0 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block0.anchorPoint = CGPointMake(0, 0);
        block0.position = CGPointMake(60, [self floorHeight]);
        [blocks insertObject:block0 atIndex:0];
        
        //block1
        CCSprite* block1 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect2];
        block1.anchorPoint = CGPointMake(0, 0);
        block1.position = CGPointMake(350,[self floorHeight]);
        [blocks insertObject:block1 atIndex:1];
        
        //block2
        CCSprite* block2 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block2.anchorPoint = CGPointMake(0, 0);
        block2.position = CGPointMake(400, [self floorHeight]);
        [blocks insertObject:block2 atIndex:2];
        
        //block3
        CCSprite* block3 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect3];
        block3.anchorPoint = CGPointMake(0, 0);
        block3.position = ccpAdd(block2.position, CGPointMake(0, rect1.size.height)) ;
        [blocks insertObject:block3 atIndex:3];
        
        CCSprite* floor = [CCSprite spriteWithFile:@"smallCube.png" rect:floorRect];
        floor.position = CGPointMake(size.width*0.5, [self floorHeight]-floorRectHalfHeight);
        
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
        
        //block action
        CCMoveTo* move0 = [CCMoveTo actionWithDuration:2 position:CGPointMake(140-rect1.size.width, [self floorHeight])];
        CCMoveTo* move1 = [CCMoveTo actionWithDuration:2 position:CGPointMake(140, [self floorHeight])];
        [block0 runAction:move0];
        [block1 runAction:move1];
        
        CCSprite* star0 = [CCSprite spriteWithFile:@"mariostar.png"];
        star0.position = CGPointMake(200, [self floorHeight]+40);
        [stars insertObject:star0 atIndex:0];
        
        CCSprite* star1 = [CCSprite spriteWithFile:@"mariostar.png"];
        star1.position = CGPointMake(240, [self floorHeight]+40);
        [stars insertObject:star1 atIndex:1];
        
        CCSprite* star2 = [CCSprite spriteWithFile:@"mariostar.png"];
        star2.position = CGPointMake(280, [self floorHeight]+40);
        [stars insertObject:star2 atIndex:2];
        
        CCRotateBy* rotate0 = [CCRotateBy actionWithDuration:4 angle:-360];
        CCRepeatForever* repeat0 = [CCRepeatForever actionWithAction:rotate0];
        [star0 runAction:repeat0];
        CCRotateBy* rotate1 = [CCRotateBy actionWithDuration:4 angle:-360];
        CCRepeatForever* repeat1 = [CCRepeatForever actionWithAction:rotate1];
        [star1 runAction:repeat1];
        CCRotateBy* rotate2 = [CCRotateBy actionWithDuration:4 angle:-360];
        CCRepeatForever* repeat2 = [CCRepeatForever actionWithAction:rotate2];
        [star2 runAction:repeat2];
        
        [self addChild:block0];
        [self addChild:block1];
        [self addChild:block2];
        [self addChild:block3];
        [self addChild:star0];
        [self addChild:star1];
        [self addChild:star2];
        [self addChild:floor];
        
        hero = [Hero heroWithParentNode:self];
        CGSize _heroSize = [hero heroSize];
        
        [hero setDestinationX:stageLength+_heroSize.width/2];
        
        [hero setPosition:CGPointMake(-_heroSize.width*0.5, [self floorHeight]+_heroSize.height*0.5)];
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
    [hero setPosition:CGPointMake(-_heroSize.width*0.5f, [self floorHeight]+_heroSize.height*0.5)];
    
    
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
            if (i == 1)
            {
                CCParticleSystemQuad* starCrash = [CCParticleSystemQuad particleWithFile:@"starCrash.plist"];
                starCrash.positionType = kCCPositionTypeFree;
                starCrash.autoRemoveOnFinish = YES;
                starCrash.position = _star.position;
                [self addChild:starCrash];
                
                CCSprite* _block = [blocks objectAtIndex:3];
                CCMoveTo* move = [CCMoveTo actionWithDuration:0.5 position:ccpAdd(_block.position, CGPointMake(0, 60))];
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
