//
//  stage5.h
//  jump
//
//  Created by yiplee  on 12-9-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"

@interface stage5 : CCLayer {
    
    Hero* hero;
    
    float floorHeight;
    float stageLength;
    
    CCArray* blocks;
    CCArray* stars;
}

@property float floorHeight;
@property float stageLength;

+ (CCScene*) scene;
@end
