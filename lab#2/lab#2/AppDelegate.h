<<<<<<< HEAD
//
//  AppDelegate.h
//  lab#2
//
//  Created by nemesis on 3/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

=======
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> 


@property (assign) IBOutlet NSWindow *window;
@property (nonatomic) BOOL isHidden;
@property (weak) IBOutlet NSSecureTextField *secureTextField;
@property (weak) IBOutlet NSTextField *centralTextField;
@property (weak) IBOutlet NSSlider *horizontalSlider;
@property (weak) IBOutlet NSSlider *verticalSlider;
@property (weak) IBOutlet NSScrollView *tableView;
@property (nonatomic, strong) NSMutableArray *people;

- (IBAction)alertPressed:(id)sender;
- (IBAction)visitRepoPressed:(id)sender;
- (IBAction)randomizePressed:(id)sender;
- (IBAction)showHidePressed:(id)sender;
- (IBAction)horizontalSliderValueChanged:(id)sender;
- (IBAction)verticalSliderValueChanged:(id)sender;

- (void) passwordEntered;
>>>>>>> working
@end
