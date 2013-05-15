//
//  mainView.h
//  lab#5
//
//  Created by nemesis on 5/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface mainView : NSView 
{
    NSImageView *imageView;
}
@property (nonatomic, retain) IBOutlet NSImageView *imageView;
@property (nonatomic, strong) IBOutlet NSTextField *label;
@property (nonatomic, strong) IBOutlet NSTextField *textCopiedLabel;
@property (nonatomic, strong) IBOutlet NSTextField *textLabel;
@property (nonatomic, strong) IBOutlet NSTextField *clipboardCleared;

- (IBAction)copy:sender;
- (IBAction)paste:sender;
- (IBAction)textCopy:(id)sender;
- (IBAction)textPaste:(id)sender;
- (IBAction)clearClipboard:(id)sender;
@end
