#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *fruitTabOne;
@property (weak) IBOutlet NSTextField *fruitTabTwo;
@property (weak) IBOutlet NSTextField *fruitFieldOne;
@property (weak) IBOutlet NSTextField *fruitFieldTwo;

- (IBAction)addOne:(id)sender;
- (IBAction)addTwo:(id)sender;
- (IBAction)clearOne:(id)sender;
- (IBAction)clearTwo:(id)sender;

@end
