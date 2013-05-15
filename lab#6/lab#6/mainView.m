#import "mainView.h"

@implementation mainView

@synthesize imageView, label, textCopiedLabel, textLabel, clipboardCleared;

- (IBAction)copy:sender {
    NSImage *image = [imageView image];
    if (image != nil) {
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        [pasteboard clearContents];
        NSArray *copiedObjects = [NSArray arrayWithObject:image];
        [pasteboard writeObjects:copiedObjects];
        //animate the text field
        [label setHidden:NO];
        
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:2.9f];
        [[label animator] setAlphaValue:0];
        [NSAnimationContext endGrouping];

        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                          target:self
                                                        selector:@selector(hideLabel)
                                                        userInfo:nil
                                                         repeats:NO];
    } else {
        NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"The image empty. Please put something into it first."];
        [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
    }
}
                          
- (void) hideLabel{
    self.label.alphaValue = 1;
    [self.label setHidden:YES];
}

- (void) hideTextLabel{
    self.textCopiedLabel.alphaValue = 1;
    [self.textCopiedLabel setHidden:YES];
}

- (void) hideClipboardClearedLabel{
    self.clipboardCleared.alphaValue = 1;
    [self.clipboardCleared setHidden:YES];
}

- (IBAction)paste:sender {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSArray *classArray = [NSArray arrayWithObject:[NSImage class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    BOOL ok = [pasteboard canReadObjectForClasses:classArray options:options];
    if (ok) {
        NSArray *objectsToPaste = [pasteboard readObjectsForClasses:classArray options:options];
        NSImage *image = [objectsToPaste objectAtIndex:0];
        [imageView setImage:image];
    } else {
        NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"You don't have a image in your clipboard."];
        [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
    }
}

- (IBAction)textCopy:(id)sender{
    
    if([[textLabel stringValue] length] != 0){
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        NSInteger changeCount = [pasteboard clearContents];
        NSArray *objectsToCopy = [NSArray arrayWithObject:[textLabel stringValue]];
        BOOL OK = [pasteboard writeObjects:objectsToCopy];
        if(OK){
            [self.textCopiedLabel setHidden:NO];
            [NSAnimationContext beginGrouping];
            [[NSAnimationContext currentContext] setDuration:2.9f];
            [[self.textCopiedLabel animator] setAlphaValue:0];
            [NSAnimationContext endGrouping];
            
            NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                              target:self
                                                            selector:@selector(hideTextLabel)
                                                            userInfo:nil
                                                             repeats:NO];
        } 
            
    } else {
    NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"The text field is empty, you can't copy nothing."];
    [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
}

}
- (IBAction)textPaste:(id)sender{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard]; 
    NSArray *classes = [[NSArray alloc] initWithObjects:[NSString class], nil];
    NSDictionary *options = [NSDictionary dictionary];
    NSArray *copiedItems = [pasteboard readObjectsForClasses:classes options:options];
    if (copiedItems != nil) {
        if(![[copiedItems objectAtIndex:0] isKindOfClass:[NSString class]]){
            NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Sorry, the object you are trying to paste is not some text."];
            [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
        }
        [textLabel setStringValue:[NSString stringWithFormat:@"%@%@",[textLabel stringValue],[copiedItems objectAtIndex:0]]];
    } if([[copiedItems objectAtIndex:0] length] == 0) {
        NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Sorry, your clipboard is empty."];
        [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
    }
}

- (IBAction)clearClipboard:(id)sender{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSInteger changeCount = [pasteboard clearContents];
    
    [self.clipboardCleared setHidden:NO];
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:2.9f];
    [[self.clipboardCleared animator] setAlphaValue:0];
    [NSAnimationContext endGrouping];
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                      target:self
                                                    selector:@selector(hideClipboardClearedLabel)
                                                    userInfo:nil
                                                     repeats:NO];
}


@end