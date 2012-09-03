//
//  Hero.h
//  jump
//
//  Created by USTB on 12-8-27.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Hero : NSObject
{
    
    CCSprite* heroSprite01;
    
    BOOL isJumping;
    BOOL isHited;
    NSInteger jumpTimes;
    float speedPerSecondX;
    float speedPerSecondY;
    float heightOfJump;
    float jumpDuration;
    float rotateAngle;
    float destinationX;
    BOOL isPassed;
    CGPoint startPoint;
}

@property BOOL isJumping;
@property BOOL isHited;
@property NSInteger jumpTimes;
@property float speedPerSecondX;
@property float speedPerSecondY;
@property float heightOfJump;
@property float jumpDuration;
@property float rotateAngle;
@property float destinationX;
@property BOOL isPassed;


+ (id) heroWithParentNode:(CCNode*)parentNode;
- (id) initWithParentNode:(CCNode*)parentNode;
- (BOOL) jump;

- (void) run:(ccTime) delta;

- (BOOL) checkHited:(CGRect) _boundingBox;

- (void) stop;

- (CGPoint) position;

- (void) setPosition:(CGPoint) _point;

- (CGSize) heroSize;

@end
