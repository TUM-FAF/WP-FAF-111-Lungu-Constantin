//
//  drawingView.m
//  lab#3
//
//  Created by nemesis on 4/30/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//


#import "drawingView.h"

@implementation drawingView
@synthesize currentMode = _currentMode;
@synthesize currentColor = _currentColor;
@synthesize allRects = _allRects;
@synthesize shouldErase = _shouldErase;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeChanged:) name:@"modeChanged" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorChanged:) name:@"colorChanged" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eraserTicked:) name:@"eraserTicked" object:nil];
        NSLog(@"%@, %@",_currentColor,_currentMode);
        _allRects = [NSMutableArray array];
        _shouldErase = NO;
        NSImageView* imgView = [[NSImageView alloc] initWithFrame:CGRectMake(600, 400, 200, 200)];
        [imgView setImage:[NSImage imageNamed:@"image.jpg"]];
        [self addSubview:imgView];
        [self setNeedsDisplay:YES];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSBezierPath *aPath = [NSBezierPath bezierPath];
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(100.0, 0.0)];
    
    // Draw the lines.
    [aPath lineToPoint:CGPointMake(200.0, 40.0)];
    [aPath lineToPoint:CGPointMake(160, 140)];
    [aPath lineToPoint:CGPointMake(40.0, 140)];
    [aPath lineToPoint:CGPointMake(0.0, 40.0)];
    [aPath closePath];
    [[NSColor redColor] set];
    [aPath fill];
    [[NSColor blueColor] set];
    [aPath stroke];
    
    [[NSColor blackColor] set];
    NSBezierPath *aPath2 = [NSBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)];
    [aPath2 stroke];

    for(int i = 0; i < [_allRects count]; i = i + 3){
        
        // Get the rect
        
        CGRect someRect = [[_allRects objectAtIndex:i] rectValue];
        
        // Determine the color 
        
        if([[_allRects objectAtIndex:i+1] isEqualToString:@"Red"]){
            [[NSColor redColor] set];
        }
        if([[_allRects objectAtIndex:i+1] isEqualToString:@"Orange"]){
            [[NSColor orangeColor] set];
        }
        if([[_allRects objectAtIndex:i+1] isEqualToString:@"Yellow"]){
            [[NSColor yellowColor] set];
        }
        if([[_allRects objectAtIndex:i+1] isEqualToString:@"Green"]){
            [[NSColor greenColor] set];
        }
        if([[_allRects objectAtIndex:i+1] isEqualToString:@"Blue"]){
            [[NSColor blueColor] set];
        }
        if([[_allRects objectAtIndex:i+1] isEqualToString:@"White"]){ // Erase
            [[NSColor whiteColor] set];
        }
        
        // Draw stuff
        
        if([[_allRects objectAtIndex:i+2] isEqualToString:@"Line mode"]){ // Is line mode
            NSBezierPath* path = [NSBezierPath bezierPath];
            [path moveToPoint:NSMakePoint(someRect.origin.x, someRect.origin.y)];
            [path lineToPoint:NSMakePoint(someRect.origin.x + someRect.size.width, someRect.origin.y + someRect.size.height)];
            [path closePath];
            [path stroke];
        }
        
        if([[_allRects objectAtIndex:i+2] isEqualToString:@"Free draw"]){ // Is free mode
            [[NSBezierPath bezierPathWithRect:someRect] fill];
        }
        
        if([[_allRects objectAtIndex:i+2] isEqualToString:@"Bezier curve"]){ // Is bezier curve
            NSBezierPath* path = [NSBezierPath bezierPath];
            [path moveToPoint:NSMakePoint(someRect.origin.x, someRect.origin.y)];
            [path curveToPoint:NSMakePoint(someRect.origin.x + someRect.size.width, someRect.origin.y + someRect.size.height) controlPoint1:NSMakePoint(someRect.origin.x + 40, someRect.origin.y + 40) controlPoint2:NSMakePoint(someRect.origin.x + someRect.size.width - 40, someRect.origin.y + someRect.size.height - 40)];
            [path closePath];
            [path stroke];
        }
        
    }
    
}

- (void) mouseDown:(NSEvent *)theEvent{
    NSPoint point = [theEvent locationInWindow];
    startPoint = [self convertPoint:point fromView:nil];
}

- (void) mouseDragged:(NSEvent *)theEvent{
    if(![_currentMode isEqualToString:@"Bezier curve"] && ![_currentMode isEqualToString:@"Delete objects"]){
    NSPoint point = [theEvent locationInWindow];
    endPoint = [self convertPoint:point fromView:nil];
    [_allRects addObject:[NSValue valueWithRect:CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, endPoint.y - startPoint.y)]];
    if(_shouldErase){
        [_allRects addObject:@"White"];
    } else {
    [_allRects addObject:_currentColor];
    }
    [_allRects addObject:_currentMode];
    [self setNeedsDisplay:YES];
    }
}

- (void) mouseUp:(NSEvent *)theEvent{

    if([_currentMode isEqualToString:@"Delete objects"]){
        NSLog(@"%@",_allRects);
        NSPoint point = [theEvent locationInWindow];
        endPoint = [self convertPoint:point fromView:nil];
        for(int i = 0; i < [_allRects count]; i = i + 6){
            if([[_allRects objectAtIndex:i] respondsToSelector:@selector(rectValue)]){
                CGRect someRect = [[_allRects objectAtIndex:i] rectValue];
                if(CGRectContainsPoint(someRect, endPoint)){
                    [_allRects addObject:[NSValue valueWithRect:someRect]];
                    [_allRects addObject:@"White"];
                    [_allRects addObject:[_allRects objectAtIndex:i+2]];
                    break;
                }
            }
        }
    } else { 
            if([_currentMode isEqualToString:@"Bezier curve"]){
        NSPoint point = [theEvent locationInWindow];
        endPoint = [self convertPoint:point fromView:nil];
        [_allRects addObject:[NSValue valueWithRect:CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, endPoint.y - startPoint.y)]];
        if(_shouldErase){
            [_allRects addObject:@"White"];
        } else {
            [_allRects addObject:_currentColor];
        }
        [_allRects addObject:_currentMode];
        [self setNeedsDisplay:YES];
    }
    }
    NSLog(@"AFTER = %@",_allRects);
    [self setNeedsDisplay:YES];
}

- (void) modeChanged:(NSNotification *)notification{
    _currentMode = [notification object];
}

- (void) colorChanged:(NSNotification *)notification{
    _currentColor = [notification object];
}

- (void) eraserTicked:(NSNotification*)notification{
    if([[notification object] state] == NSOnState){
        _shouldErase = YES;
        NSLog(@"SHOULD ERASE");
    } else {
        _shouldErase = NO;
        NSLog(@"SHOULDNT ERASE");
    }
}

@end
