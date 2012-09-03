//
//  stage10.h
//  jump
//
//  Created by yiplee  on 12-9-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"

@interface stage10 : CCLayer {
    
    Hero* hero;
    CCSprite* bigStar;
    
    float floorHeight;
    float stageLength;
}

@property float floorHeight;
@property float stageLength;

+ (CCScene*) scene;

@end
