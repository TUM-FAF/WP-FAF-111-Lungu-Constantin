//
//  mainView.m
//  lab#4
//
//  Created by nemesis on 5/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "mainView.h"

@implementation mainView

@synthesize timer = _timer, redBall = _redBall, blueBall = _blueBall, greenBall = _greenBall, yellowBall = _yellowBall, orangeBall = _orangeBall, ballCount = _ballCount, ballsDirections = _ballsDirections, isAnimatingAtTheMoment = _isAnimatingAtTheMoment;

NSButton* startButton, *myCheckBox;
NSButton* plusButton, *minusButton;
float velocity;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ballCount = 0;
        velocity = 1;
        _isAnimatingAtTheMoment = NO;
        startButton = [[NSButton alloc] initWithFrame:CGRectMake(396, 324, 60, 30)];
        [startButton setTitle:@"Start"];
        [startButton setTarget:self];
        [startButton setAction:@selector(buttonPressed)];
        [self addSubview:startButton];
        
        myCheckBox = [[NSButton alloc] initWithFrame:CGRectMake(5, 330, 300, 30)];
        [myCheckBox setButtonType:NSSwitchButton];
        [myCheckBox setTitle:@"Randomize directions on start"];
        [self addSubview:myCheckBox];
        
        plusButton = [[NSButton alloc] initWithFrame:CGRectMake(396, 294, 30, 30)];
        [plusButton setTitle:@"+"];
        [plusButton setTarget:self];
        [plusButton setAction:@selector(plusPressed)];
        [self addSubview:plusButton];
        
        minusButton = [[NSButton alloc] initWithFrame:CGRectMake(426, 294, 30, 30)];
        [minusButton setTitle:@"-"];
        [minusButton setTarget:self];
        [minusButton setAction:@selector(minusPressed)];
        [self addSubview:minusButton];
    }
    return self;
}

- (void) plusPressed{
    velocity += 0.25;
    if (velocity >= 3) {
        plusButton.alphaValue = 0.5;
        [plusButton setEnabled:NO];
    } if(velocity < 3){
        plusButton.alphaValue = 1;
        [plusButton setEnabled:YES];
    }
    if(velocity > 0.1){
        minusButton.alphaValue = 1;
        [minusButton setEnabled:YES];
    }
}

- (void) minusPressed{
    velocity -= 0.25;
    if(velocity <= 0.1){
        velocity = 0.11;
        minusButton.alphaValue = 0.5;
        [minusButton setEnabled:NO];
    }
    if(velocity < 3){
        plusButton.alphaValue = 1;
        [plusButton setEnabled:YES];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    
}

- (void) buttonPressed{
    if ([[startButton title] isEqualToString:@"Start"]) {
        if(_ballCount != 0){
        [startButton setTitle:@"Stop"];
        [myCheckBox setHidden:YES];
        [self startAnimations];
        } else {
            NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"There are no balls in the current view (click to add one)"];
            [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
        }
        
    } else if([[startButton title] isEqualToString:@"Stop"]){
        [startButton setTitle:@"Start"];
        [myCheckBox setHidden:NO];
        [self endAnimations];
    }
}

- (void) mouseUp:(NSEvent *)theEvent{
    NSPoint thePoint = [theEvent locationInWindow];
    if(_isAnimatingAtTheMoment){
        [self endAnimations];
    }
    switch (_ballCount) {
        case 0:
            _redBall = [[NSImageView alloc] initWithFrame:CGRectMake(thePoint.x, thePoint.y, 25, 25)];
            [_redBall setImage:[NSImage imageNamed:@"redBall.png"]];
            [self addSubview:_redBall];
            _ballsDirections = [NSMutableArray array];
            
            // DEFINE A DIRECTION FOR THE BALL
            
            if(arc4random() % 2 == 0){
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Up"];
                } else {
                    [_ballsDirections addObject:@"Left"];
                }
            } else {
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Down"];
                } else {
                    [_ballsDirections addObject:@"Right"];
                }
            }
            
            _ballCount++;
            break;
        case 1:
            _blueBall = [[NSImageView alloc] initWithFrame:CGRectMake(thePoint.x, thePoint.y, 25, 25)];
            [_blueBall setImage:[NSImage imageNamed:@"blueBall.png"]];
            [self addSubview:_blueBall];
            
            // DEFINE A DIRECTION FOR THE BALL
            
            if(arc4random() % 2 == 0){
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Up"];
                } else {
                    [_ballsDirections addObject:@"Left"];
                }
            } else {
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Down"];
                } else {
                    [_ballsDirections addObject:@"Right"];
                }
            }
            
            _ballCount++;
            break;
        case 2:
            _greenBall = [[NSImageView alloc] initWithFrame:CGRectMake(thePoint.x, thePoint.y, 25, 25)];
            [_greenBall setImage:[NSImage imageNamed:@"greenBall.png"]];
            [self addSubview:_greenBall];
            
            // DEFINE A DIRECTION FOR THE BALL
            
            if(arc4random() % 2 == 0){
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Up"];
                } else {
                    [_ballsDirections addObject:@"Left"];
                }
            } else {
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Down"];
                } else {
                    [_ballsDirections addObject:@"Right"];
                }
            }
            
            _ballCount++;
            break;
        case 3:
            _yellowBall = [[NSImageView alloc] initWithFrame:CGRectMake(thePoint.x, thePoint.y, 25, 25)];
            [_yellowBall setImage:[NSImage imageNamed:@"yellowBall.png"]];
            [self addSubview:_yellowBall];
            
            // DEFINE A DIRECTION FOR THE BALL
            
            if(arc4random() % 2 == 0){
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Up"];
                } else {
                    [_ballsDirections addObject:@"Left"];
                }
            } else {
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Down"];
                } else {
                    [_ballsDirections addObject:@"Right"];
                }
            }
            
            _ballCount++;
            break;
        case 4:
            _orangeBall = [[NSImageView alloc] initWithFrame:CGRectMake(thePoint.x, thePoint.y, 25, 25)];
            [_orangeBall setImage:[NSImage imageNamed:@"orangeBall"]];
            [self addSubview:_orangeBall];
            
            // DEFINE A DIRECTION FOR THE BALL
            
            if(arc4random() % 2 == 0){
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Up"];
                } else {
                    [_ballsDirections addObject:@"Left"];
                }
            } else {
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Down"];
                } else {
                    [_ballsDirections addObject:@"Right"];
                }
            }
            
            _ballCount++;
            break;
        case 5:
            break;
        default:
            break;
    }
    if(_isAnimatingAtTheMoment){
        [self startAnimations];
    }
}

- (void) moveBalls{
    
    // RED BALL
    
    if(_redBall){
        if([[_ballsDirections objectAtIndex:0] isEqualToString:@"Up"]){
            _redBall.frame = CGRectMake(_redBall.frame.origin.x, _redBall.frame.origin.y + velocity, 25, 25);
            NSLog(@"%f",_redBall.frame.origin.y);
            if(_redBall.frame.origin.y >= 335){
                [_ballsDirections replaceObjectAtIndex:0 withObject:@"Down"];
            }
        } else if([[_ballsDirections objectAtIndex:0] isEqualToString:@"Down"]) {
            _redBall.frame = CGRectMake(_redBall.frame.origin.x, _redBall.frame.origin.y - velocity, 25, 25);
            if(_redBall.frame.origin.y <= 0){
                [_ballsDirections replaceObjectAtIndex:0 withObject:@"Up"];
            }
        } else if([[_ballsDirections objectAtIndex:0] isEqualToString:@"Left"]){
            _redBall.frame = CGRectMake(_redBall.frame.origin.x - velocity, _redBall.frame.origin.y, 25, 25);
            if(_redBall.frame.origin.x <= 0){
                [_ballsDirections replaceObjectAtIndex:0 withObject:@"Right"];
            }
        } else {
            _redBall.frame = CGRectMake(_redBall.frame.origin.x + velocity, _redBall.frame.origin.y, 25, 25);
            if(_redBall.frame.origin.x >= 455){
                [_ballsDirections replaceObjectAtIndex:0 withObject:@"Left"];
            }
        }
    }
    
    // BLUE BALL
    
    if(_blueBall){
        if([[_ballsDirections objectAtIndex:1] isEqualToString:@"Up"]){
            _blueBall.frame = CGRectMake(_blueBall.frame.origin.x, _blueBall.frame.origin.y + velocity, 25, 25);
            if(_blueBall.frame.origin.y >= 335){
                [_ballsDirections replaceObjectAtIndex:1 withObject:@"Down"];
            }
        } else if([[_ballsDirections objectAtIndex:1] isEqualToString:@"Down"]) {
            _blueBall.frame = CGRectMake(_blueBall.frame.origin.x, _blueBall.frame.origin.y - velocity, 25, 25);
            if(_blueBall.frame.origin.y <= 0){
                [_ballsDirections replaceObjectAtIndex:1 withObject:@"Up"];
            }
        } else if([[_ballsDirections objectAtIndex:1] isEqualToString:@"Left"]){
            _blueBall.frame = CGRectMake(_blueBall.frame.origin.x - velocity, _blueBall.frame.origin.y, 25, 25);
            if(_blueBall.frame.origin.x <= 0){
                [_ballsDirections replaceObjectAtIndex:1 withObject:@"Right"];
            }
        } else {
            _blueBall.frame = CGRectMake(_blueBall.frame.origin.x + velocity, _blueBall.frame.origin.y, 25, 25);
            if(_blueBall.frame.origin.x >= 455){
                [_ballsDirections replaceObjectAtIndex:1 withObject:@"Left"];
            }
        }
    }
    
    // GREEN BALL
    
    if(_greenBall){
        if([[_ballsDirections objectAtIndex:2] isEqualToString:@"Up"]){
            _greenBall.frame = CGRectMake(_greenBall.frame.origin.x, _greenBall.frame.origin.y + velocity, 25, 25);
            if(_greenBall.frame.origin.y >= 335){
                [_ballsDirections replaceObjectAtIndex:2 withObject:@"Down"];
            }
        } else if([[_ballsDirections objectAtIndex:2] isEqualToString:@"Down"]) {
            _greenBall.frame = CGRectMake(_greenBall.frame.origin.x, _greenBall.frame.origin.y - velocity, 25, 25);
            if(_greenBall.frame.origin.y <= 0){
                [_ballsDirections replaceObjectAtIndex:2 withObject:@"Up"];
            }
        } else if([[_ballsDirections objectAtIndex:2] isEqualToString:@"Left"]){
            _greenBall.frame = CGRectMake(_greenBall.frame.origin.x - velocity, _greenBall.frame.origin.y, 25, 25);
            if(_greenBall.frame.origin.x <= 0){
                [_ballsDirections replaceObjectAtIndex:2 withObject:@"Right"];
            }
        } else {
            _greenBall.frame = CGRectMake(_greenBall.frame.origin.x + velocity, _greenBall.frame.origin.y, 25, 25);
            if(_greenBall.frame.origin.x >= 455){
                [_ballsDirections replaceObjectAtIndex:2 withObject:@"Left"];
            }
        }
    }
    
    // YELLOW BALL 
    
    if(_yellowBall){
        if([[_ballsDirections objectAtIndex:3] isEqualToString:@"Up"]){
            _yellowBall.frame = CGRectMake(_yellowBall.frame.origin.x, _yellowBall.frame.origin.y + velocity, 25, 25);
            if(_yellowBall.frame.origin.y >= 335){
                [_ballsDirections replaceObjectAtIndex:3 withObject:@"Down"];
            }
        } else if([[_ballsDirections objectAtIndex:3] isEqualToString:@"Down"]) {
            _yellowBall.frame = CGRectMake(_yellowBall.frame.origin.x, _yellowBall.frame.origin.y - velocity, 25, 25);
            if(_yellowBall.frame.origin.y <= 0){
                [_ballsDirections replaceObjectAtIndex:3 withObject:@"Up"];
            }
        } else if([[_ballsDirections objectAtIndex:3] isEqualToString:@"Left"]){
            _yellowBall.frame = CGRectMake(_yellowBall.frame.origin.x - velocity, _yellowBall.frame.origin.y, 25, 25);
            if(_yellowBall.frame.origin.x <= 0){
                [_ballsDirections replaceObjectAtIndex:3 withObject:@"Right"];
            }
        } else {
            _yellowBall.frame = CGRectMake(_yellowBall.frame.origin.x + velocity, _yellowBall.frame.origin.y, 25, 25);
            if(_yellowBall.frame.origin.x >= 455){
                [_ballsDirections replaceObjectAtIndex:3 withObject:@"Left"];
            }
        }
    }

    // ORANGE BALL
    
    if(_orangeBall){
        if([[_ballsDirections objectAtIndex:4] isEqualToString:@"Up"]){
            _orangeBall.frame = CGRectMake(_orangeBall.frame.origin.x, _orangeBall.frame.origin.y + velocity, 25, 25);
            if(_orangeBall.frame.origin.y >= 335){
                [_ballsDirections replaceObjectAtIndex:4 withObject:@"Down"];
            }
        } else if([[_ballsDirections objectAtIndex:4] isEqualToString:@"Down"]) {
            _orangeBall.frame = CGRectMake(_orangeBall.frame.origin.x, _orangeBall.frame.origin.y - velocity, 25, 25);
            if(_orangeBall.frame.origin.y <= 0){
                [_ballsDirections replaceObjectAtIndex:4 withObject:@"Up"];
            }
        } else if([[_ballsDirections objectAtIndex:4] isEqualToString:@"Left"]){
            _orangeBall.frame = CGRectMake(_orangeBall.frame.origin.x - velocity, _orangeBall.frame.origin.y, 25, 25);
            if(_orangeBall.frame.origin.x <= 0){
                [_ballsDirections replaceObjectAtIndex:4 withObject:@"Right"];
            }
        } else {
            _orangeBall.frame = CGRectMake(_orangeBall.frame.origin.x + velocity, _orangeBall.frame.origin.y, 25, 25);
            if(_orangeBall.frame.origin.x >= 455){
                [_ballsDirections replaceObjectAtIndex:4 withObject:@"Left"];
            }
        }
    }
    
    if(_ballCount >= 2){
    [self checkIfBallsIntersect];
    }
}

- (void) startAnimations{
    NSLog(@"%@",_ballsDirections);
    
    if([myCheckBox state] == NSOnState){
        _ballsDirections = nil;
        _ballsDirections = [NSMutableArray array];
        
        for(int i = 0; i < _ballCount; i++){
            if(arc4random() % 2 == 0){
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Up"];
                } else {
                    [_ballsDirections addObject:@"Left"];
                }
            } else {
                if(arc4random() %2 == 0){
                    [_ballsDirections addObject:@"Down"];
                } else {
                    [_ballsDirections addObject:@"Right"];
                }
            }
        }
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(moveBalls) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void) checkIfBallsIntersect{
    CGRect red,blue,green,yellow,orange;
    red = _redBall.frame;
    blue = _blueBall.frame;
    if(_greenBall){
    green = _greenBall.frame;
    }
    if(_yellowBall){
    yellow = _yellowBall.frame;
    }
    if(_orangeBall){
    orange = _orangeBall.frame;
    }
    
    
    [self customRectanglesIntersection:red with:blue];
    [self customRectanglesIntersection:red with:green];
    [self customRectanglesIntersection:red with:yellow];
    [self customRectanglesIntersection:red with:orange];
    
    [self customRectanglesIntersection:blue with:green];
    [self customRectanglesIntersection:blue with:yellow];
    [self customRectanglesIntersection:blue with:orange];
    
    [self customRectanglesIntersection:green with:yellow];
    [self customRectanglesIntersection:green with:orange];
    
    [self customRectanglesIntersection:yellow with:orange];
    
}
                                                                            
- (void) customRectanglesIntersection:(CGRect) first with:(CGRect) second{
    int firstIndex, secondIndex;
    
    CGRect red,blue,green,yellow,orange;
    red = _redBall.frame;
    blue = _blueBall.frame;
    if(_greenBall){
        green = _greenBall.frame;
    }
    if(_yellowBall){
        yellow = _yellowBall.frame;
    }
    if(_orangeBall){
        orange = _orangeBall.frame;
    }
    
    // Determine what rects were passed in the function
    
    if(CGRectEqualToRect(first, red)){
        firstIndex = 0;
    }
    if(CGRectEqualToRect(first, blue)){
        firstIndex = 1;
    }
    if(CGRectEqualToRect(first, green)){
        firstIndex = 2;
    }
    if(CGRectEqualToRect(first, yellow)){
        firstIndex = 3;
    }
    if(CGRectEqualToRect(first, orange)){
        firstIndex = 4;
    }
    
    if(CGRectEqualToRect(second, red)){
        secondIndex = 0;
    }
    if(CGRectEqualToRect(second, blue)){
        secondIndex = 1;
    }
    if(CGRectEqualToRect(second, green)){
        secondIndex = 2;
    }
    if(CGRectEqualToRect(second, yellow)){
        secondIndex = 3;
    }
    if(CGRectEqualToRect(second, orange)){
        secondIndex = 4;
    }
    
    if (CGRectIntersectsRect(first, second)) {
        // If one ball is moving horizontally and another one vertically
        if([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Left"] && 
           ([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Up"] || 
            [[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Down"])){
               [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Right"];
        }
        if([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Right"] && 
           ([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Up"] || 
            [[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Down"])){
               [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Left"];
           }
        if([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Up"] && 
           ([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Left"] || 
            [[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Right"])){
               [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Down"];
           }
        if([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Down"] && 
           ([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Left"] || 
            [[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Right"])){
               [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Up"];
           }
        // If both balls are moving horizontally
        
        if([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Left"] && 
           ([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Right"])){
               [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Right"];
               [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Left"];
           }
        
        if([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Right"] && 
           ([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Left"])){
            [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Left"];
            [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Right"];
        }
        
        // If both balls are moving vertically
        
        if([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Up"] && 
           ([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Down"])){
            [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Down"];
            [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Up"];
        }
        
        if([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Down"] && 
           ([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Up"])){
            [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Up"];
            [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Down"];
        }
        
        // Reversed way of approaching this
        
        if([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Left"] && 
           ([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Up"] || 
            [[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Down"])){
               [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Right"];
           }
        if([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Right"] && 
           ([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Up"] || 
            [[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Down"])){
               [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Left"];
           }
        if([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Up"] && 
           ([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Left"] || 
            [[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Right"])){
               [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Down"];
           }
        if([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Down"] && 
           ([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Left"] || 
            [[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Right"])){
               [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Up"];
           }
        // If both balls are moving horizontally
        
        if([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Left"] && 
           ([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Right"])){
            [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Right"];
            [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Left"];
        }
        
        if([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Right"] && 
           ([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Left"])){
            [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Left"];
            [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Right"];
        }
        
        // If both balls are moving vertically
        
        if([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Up"] && 
           ([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Down"])){
            [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Down"];
            [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Up"];
        }
        
        if([[_ballsDirections objectAtIndex:secondIndex] isEqualToString:@"Down"] && 
           ([[_ballsDirections objectAtIndex:firstIndex] isEqualToString:@"Up"])){
            [_ballsDirections replaceObjectAtIndex:secondIndex withObject:@"Up"];
            [_ballsDirections replaceObjectAtIndex:firstIndex withObject:@"Down"];
        }
    }
}



- (void) endAnimations {
    [_timer invalidate];
}

@end
