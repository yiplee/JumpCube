//
//  stage7.h
//  jump
//
//  Created by yiplee  on 12-9-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"

@interface stage7 : CCLayer {
    
    Hero* hero;
    
    float floorHeight;
    float stageLength;
    
    CCArray* blocks;
    
    CCParticleSystemQuad* comet;
    BOOL cometOn;
}

@property float floorHeight;
@property float stageLength;

+ (CCScene*) scene;

@end
