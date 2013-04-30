#import "AppDelegate.h"
#import "Quartz/Quartz.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize popUpList = _popUpList;
@synthesize colorPopUpList = _colorPopUpList;
@synthesize checkBox = _checkBox;
@synthesize currentMode = _currentMode;
@synthesize currentColor = _currentColor;
@synthesize dv = _dv;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setBackgroundColor:[NSColor whiteColor]];
    NSArray* itemsForPopUpList = [NSArray arrayWithObjects:@"Line mode",@"Free draw",@"Bezier curve",@"Delete objects", nil];
    [_popUpList removeAllItems];
    [_popUpList addItemsWithTitles:itemsForPopUpList];
    NSArray* colors = [NSArray arrayWithObjects:@"Red",@"Orange",@"Yellow",@"Green",@"Blue", nil];
    [_colorPopUpList removeAllItems];
    [_colorPopUpList addItemsWithTitles:colors];
    _currentMode = @"Line mode";
    _currentColor = @"Red";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"modeChanged" object:_currentMode];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorChanged" object:_currentColor];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"eraserTicked" object:_checkBox];
}

- (IBAction)valueChanged:(id)sender {
    _currentMode = [[_popUpList selectedItem] title];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"modeChanged" object:_currentMode];
}

- (IBAction)colorValueChanged:(id)sender {
    _currentColor = [[_colorPopUpList selectedItem] title];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorChanged" object:_currentColor];
}

- (IBAction)eraserTicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"eraserTicked" object:_checkBox];
}

- (BOOL)acceptsFirstResponder{
    return YES;
}

@end
