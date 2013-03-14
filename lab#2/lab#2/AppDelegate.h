#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> 

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic) BOOL isHidden;
@property (weak) IBOutlet NSSecureTextField *secureTextField;
@property (weak) IBOutlet NSTextField *centralTextField;

- (IBAction)alertPressed:(id)sender;
- (IBAction)visitRepoPressed:(id)sender;
- (IBAction)randomizePressed:(id)sender;
- (IBAction)showHidePressed:(id)sender;

- (void) passwordEntered;
@end
