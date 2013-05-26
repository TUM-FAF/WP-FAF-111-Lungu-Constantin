//
//  AppDelegate.h
//  lab#5
//
//  Created by Constantin Lungu on 5/22/13.
//  Copyright (c) 2013 Constantin Lungu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTextFieldDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *outputField;
@property (weak) IBOutlet NSTextField *commandField;

@property (nonatomic) NSString* currentPath;

@end
