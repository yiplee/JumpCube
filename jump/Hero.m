//
//  Hero.m
//  jump
//
//  Created by USTB on 12-8-27.
//
//

#import "Hero.h"
#import "gameStaticData.h"

@implementation Hero

@synthesize isJumping;
@synthesize isHited;
@synthesize jumpTimes;
@synthesize speedPerSecondX;
@synthesize speedPerSecondY;
@synthesize heightOfJump;
@synthesize jumpDuration;
@synthesize rotateAngle;
@synthesize destinationX;
@synthesize isPassed;


+ (id) heroWithParentNode:(CCNode *)parentNode
{
    return [[[self alloc] initWithParentNode:parentNode] autorelease];
}

- (id) initWithParentNode:(CCNode *)parentNode
{
    if (self = [super init])
    {
        [self setIsHited:NO];
        [self setIsPassed:NO];
        heroSprite01 = [CCSprite spriteWithFile:@"hero.png"];
        [parentNode addChild:heroSprite01];
        
        [self setIsJumping:NO];
        [self setJumpTimes:0];
        [self setIsHited:NO];
        if ([[gameStaticData sharedStaticData]level] == 0)
            [self setSpeedPerSecondX:100];
        else if ([[gameStaticData sharedStaticData]level] == 1)
            [self setSpeedPerSecondX:120];
        else [self setSpeedPerSecondX:130];
        [self setSpeedPerSecondY:0];
        [self setHeightOfJump:64];
        [self setJumpDuration:1];
        [self setRotateAngle:-180];
        [self setIsPassed:NO];
        //Manually schedule
        //[[CCScheduler sharedScheduler] scheduleUpdateForTarget:self priority:0 paused:NO];
    }
    return self;
}

- (BOOL) checkHited:(CGRect) _boundingBox
{
    [self setIsHited:CGRectIntersectsRect(_boundingBox, heroSprite01.boundingBox)];
    return [self isHited];
}



- (BOOL) jump
{
    int _jumpTimes = [self jumpTimes];
    if (_jumpTimes > 0)
        return NO;
    else if (_jumpTimes == 0)
    {
        [self setJumpTimes:_jumpTimes+1];
        
        //run action sequence
        CGPoint _newPosition ;
        _newPosition.x = heroSprite01.position.x + speedPerSecondX * jumpDuration;
        _newPosition.y = heroSprite01.position.y;
        CCJumpTo* jump = [CCJumpTo actionWithDuration:jumpDuration position:_newPosition height:heightOfJump jumps:1];
        
        CCRotateBy* rotate = [CCRotateBy actionWithDuration:jumpDuration angle:rotateAngle];
        
        CCCallFunc* functionAfterJumpDone = [CCCallFunc actionWithTarget:self selector:@selector(jumpDone)];
        
        CCSequence* seq = [CCSequence actions:jump,functionAfterJumpDone, nil];
        
        [heroSprite01 runAction:seq];
        [heroSprite01 runAction:rotate];
        
        return YES;
    }
    else
    {
        CCLOG(@"Error:jumpTimes<0");
        return NO;
    }
}

- (void) jumpDone
{
    [self setJumpTimes:0];
}

- (void) run:(ccTime) delta
{
    CGPoint moveTo = CGPointMake(speedPerSecondX*delta, speedPerSecondY*delta);
    heroSprite01.position = ccpAdd(heroSprite01.position, moveTo);
}

- (void) stop
{
    
    if ([heroSprite01 numberOfRunningActions]>0)
    {
        [heroSprite01 stopAllActions];
    }
    [self jumpDone];
    [heroSprite01 setRotation:0];
}



- (CGSize) heroSize
{
    return [heroSprite01 texture].contentSize;
}

- (CGPoint) position
{
    
    return heroSprite01.position;
}

- (void) setPosition:(CGPoint)_point
{
    heroSprite01.position = _point;
}

- (void) dealloc
{
    //[heroSprite01 stopAllActions];
    //[[CCScheduler sharedScheduler] unscheduleUpdateForTarget:self];
    [super dealloc];
}

@end
