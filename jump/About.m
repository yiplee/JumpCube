//
//  About.m
//  jump
//
//  Created by yiplee  on 12-8-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "About.h"
#import "MainMenuLayer.h"

@implementation About

+ (CCScene*) scene
{
    CCScene* scene = [CCScene node];
    About* about = [About node];
    [scene addChild:about];
    return scene;
}

- (id) init
{
    if (self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        NSString* string = @"JumpCube\nVersion:1.0\n\nBug Report:\nguoyinl@gmail.com";
        CCLabelTTF* info = [CCLabelTTF labelWithString:string fontName:@"STHeitiK-Light" fontSize:24];
        info.position = CGPointMake(size.width*0.5, size.height*0.6);
        [self addChild:info z:1];
        
        CCLabelBMFont* label = [CCLabelBMFont labelWithString:@"BACK" fntFile:@"BlockFont3.fnt"];
        CCMenuItemLabel* back = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(backPressed)];
        CCMenu* menu = [CCMenu menuWithItems:back, nil];
        menu.position = CGPointMake(size.width*0.5, size.height*0.1);
        [self addChild:menu z:2];
    }
    return self;
}

- (void) backPressed
{
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}

- (void) dealloc
{
    [super dealloc];
}

@end
