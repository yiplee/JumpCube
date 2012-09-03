//
//  MainMenu.h
//  jump
//
//  Created by USTB on 12-8-27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"

@interface MainMenu : CCLayer
{
    Hero* hero;
}

+ (CCScene *) scene;

@end
