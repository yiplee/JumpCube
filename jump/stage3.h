//
//  stage3.h
//  jump
//
//  Created by USTB on 12-8-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"

@interface stage3 : CCLayer
{
    Hero* hero;
    
    float floorHeight;
    float stageLength;
    
    CCArray* blocks;
}

@property float floorHeight;
@property float stageLength;

+ (CCScene*) scene;

@end
