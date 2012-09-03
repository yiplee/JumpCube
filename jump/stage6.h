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

@interface stage6 : CCLayer {
    
    Hero* hero;
    
    float floorHeight;
    float stageLength;
    
    CCArray* blocks;
    
    BOOL action1Done;
    BOOL action2Done;
    BOOL action3Done;
}

@property float floorHeight;
@property float stageLength;

+ (CCScene*) scene;

@end
