//
//  IntroLayer.m
//  jump
//
//  Created by USTB on 12-8-27.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "MainMenuLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(void) onEnter
{
	[super onEnter];

	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];

	CCSprite *background;
	
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
		background = [CCSprite spriteWithFile:@"Default.png"];
		background.rotation = 90;
	} else {
		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
	}
	background.position = ccp(size.width/2, size.height/2);
    
    CCLabelBMFont *label = [CCLabelBMFont labelWithString:@"LOADING..." fntFile:@"BlockFont3.fnt"];
    //CCLabelTTF* label = [CCLabelTTF labelWithString:@"Loading ...." fontName:@"Marker Felt" fontSize:24];
    label.position = ccp(size.width*0.5,size.height*0.1);
	[self addChild:background z:1];
    [self addChild:label z:2];
	
	// In one second transition to the new scene
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuLayer scene] withColor:ccWHITE]];
}
@end
