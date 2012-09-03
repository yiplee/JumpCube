//
//  option.h
//  jump
//
//  Created by USTB on 12-8-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"

@interface Option : CCLayer
{
    CCLabelBMFont* bgMusicOptionLabel;
    CCLabelBMFont* gameLevelLabel;
    CCLabelBMFont* backLabel;
}

+ (CCScene*) scene;

@end
