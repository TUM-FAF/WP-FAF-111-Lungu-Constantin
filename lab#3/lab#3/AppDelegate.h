#import <Cocoa/Cocoa.h>
#import "drawingView.h"

@class drawingView;

@interface AppDelegate : NSObject {
}

@property (assign) IBOutlet NSWindow *window;
@property IBOutlet drawingView* dv;

@property NSString* currentMode;
@property NSString* currentColor;

@property (weak) IBOutlet NSPopUpButton *popUpList;
@property (weak) IBOutlet NSPopUpButton *colorPopUpList;
@property (weak) IBOutlet NSButton *checkBox;
- (IBAction)valueChanged:(id)sender;
- (IBAction)colorValueChanged:(id)sender;
- (IBAction)eraserTicked:(id)sender;
@end
