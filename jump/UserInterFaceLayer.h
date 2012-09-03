//
//  UserInterFaceLayer.h
//  jump
//
//  Created by yiplee  on 12-8-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UserInterFaceLayer : CCLayer
{
    int displayLife;
    int displayStage;
    CCLabelBMFont* lifeLabel;
    CCLabelBMFont* stageLabel;
    CCLabelBMFont* mutelabel;
    CCLabelBMFont* pauseLabel;
}

@property int displayLife;
@property int displayStage;

+ (CCScene*) scene;

@end
