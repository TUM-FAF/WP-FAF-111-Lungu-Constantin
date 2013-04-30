//
//  drawingView.h
//  lab#3
//
//  Created by nemesis on 4/30/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@class AppDelegate;

@interface drawingView : NSView <NSApplicationDelegate>{
    NSPoint startPoint;
    NSPoint endPoint;
}

@property NSString* currentMode;
@property NSString* currentColor;
@property NSMutableArray* allRects;
@property BOOL shouldErase;

- (void) modeChanged:(NSNotification*)notification;
- (void) colorChanged:(NSNotification*)notification;
- (void) eraserTicked:(NSNotification*)notification;
@end
