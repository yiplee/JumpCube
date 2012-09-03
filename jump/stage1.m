//
//  stage1.m
//  jump
//
//  Created by USTB on 12-8-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "stage1.h"
#import "gameStaticData.h"

@implementation stage1

@synthesize floorHeight;
@synthesize stageLength;

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    stage1* stage = [stage1 node];
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
        
        CGRect rect1 = CGRectMake(120, [self floorHeight], 20, 30);
        CGRect rect2 = CGRectMake(360, [self floorHeight], 25, 30);
        CGRect floorRect = CGRectMake(0, 0, stageLength, 10);
        
        CCSprite* block1 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect1];
        block1.position = CGPointMake(140, [self floorHeight]+15);
        [blocks addObject:block1];
        
        CCSprite* block2 = [CCSprite spriteWithFile:@"smallCube.png" rect:rect2];
        block2.position = CGPointMake(380, [self floorHeight]+15);
        [blocks addObject:block2];
        
        
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
        [floor.texture setTexParameters:&params];
        
        [self addChild:block1 z:0 tag:1];
        [self addChild:block2 z:1 tag:2];
        [self addChild:floor z:10 tag:10];
        
        hero = [Hero heroWithParentNode:self];
        CGSize _heroSize = [hero heroSize];
        
        [hero setDestinationX:stageLength+_heroSize.width/2];
        
        [hero setPosition:CGPointMake(-_heroSize.width*0.5, floorHeight+_heroSize.height*0.5)];
        [hero retain];
        
        CCLabelBMFont* messageLabel = [CCLabelBMFont labelWithString:@"TOUCH.TO.JUMP" fntFile:@"BlockFont3.fnt"];
        messageLabel.position = CGPointMake(size.width*0.5, size.height*0.75);
        [self addChild:messageLabel];
        
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
