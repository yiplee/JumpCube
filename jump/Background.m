//
//  Background.m
//  jump
//
//  Created by USTB on 12-8-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Background.h"

@implementation Background

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    Background* bg = [Background node];
    [scene addChild:bg];
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
        [self addChild:starNight];
        [self setIsTouchEnabled:NO];
    }
    return self;
}


- (void) dealloc
{
    [super dealloc];
}
@end
