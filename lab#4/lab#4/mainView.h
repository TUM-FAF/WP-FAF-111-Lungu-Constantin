//
//  mainView.h
//  lab#4
//
//  Created by nemesis on 5/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface mainView : NSView

@property (nonatomic, strong) NSTimer* timer;

@property (nonatomic, strong) NSImageView* redBall;
@property (nonatomic, strong) NSImageView* blueBall;
@property (nonatomic, strong) NSImageView* greenBall;
@property (nonatomic, strong) NSImageView* yellowBall;
@property (nonatomic, strong) NSImageView* orangeBall;

@property (nonatomic, strong) NSMutableArray* ballsDirections;

@property (nonatomic) BOOL isAnimatingAtTheMoment;

@property (nonatomic) NSInteger ballCount;

@end
