#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize isHidden = _isHidden;
@synthesize secureTextField = _secureTextField;
@synthesize centralTextField = _centralTextField;
@synthesize horizontalSlider = _horizontalSlider;
@synthesize verticalSlider = _verticalSlider;
@synthesize tableView = _tableView;
@synthesize people = _people;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _isHidden = FALSE;
    [self.secureTextField setTarget:self];
    [self.secureTextField setAction:@selector(passwordEntered)];
    
    
}

- (IBAction)alertPressed:(id)sender {
    NSAlert *myAlert = [NSAlert alertWithMessageText:@"Alert" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Hey, you've pressed the alert button! Here you go with a notification."];
    [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
}

- (IBAction)visitRepoPressed:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/TUM-FAF/WP-FAF-111-Lungu-Constantin"]];
}

- (IBAction)randomizePressed:(id)sender {
    [_window setAlphaValue:0.6 + ((double)(arc4random()%5)/5)];
    CGRect myRect = CGRectMake(arc4random()%800, arc4random()%800, 400+arc4random()%400, 400+arc4random()%400);
    [_window setFrame:NSRectFromCGRect(myRect) display:TRUE];
}

- (IBAction)showHidePressed:(id)sender {
    if(!_isHidden){
    [_window setIsVisible:FALSE];
        _isHidden = TRUE;
        }
    else if(_isHidden){
    [_window setIsVisible:TRUE];
    _isHidden = FALSE;
    }
}

- (void) passwordEntered{
    if([self.secureTextField.stringValue caseInsensitiveCompare:@"constantin"] == NSOrderedSame){
        NSRunAlertPanel(@"Correct!", @"You know my surname!", @"OK", nil, nil);
    }
    else {
        NSRunAlertPanel(@"Wrong!", @"That's not my surname!", @"OK", nil, nil);
    }
}

- (IBAction)horizontalSliderValueChanged:(id)sender {
    if([_horizontalSlider doubleValue] == 0){
        [self.centralTextField setTextColor:[NSColor blackColor]];
    }
    if([_horizontalSlider doubleValue] > 15){
    [self.centralTextField setTextColor:[NSColor grayColor]];
    }
    if([_horizontalSlider doubleValue] > 30){
        [self.centralTextField setTextColor:[NSColor whiteColor]];
    }
    if([_horizontalSlider doubleValue] > 50){
        [self.centralTextField setTextColor:[NSColor yellowColor]];
    }
    if([_horizontalSlider doubleValue] > 65){
        [self.centralTextField setTextColor:[NSColor greenColor]];
    }
    if([_horizontalSlider doubleValue] > 80){
        [self.centralTextField setTextColor:[NSColor redColor]];
    }
    if([_horizontalSlider doubleValue] == 100){
        [self.centralTextField setTextColor:[NSColor blueColor]];
    }
}

- (IBAction)verticalSliderValueChanged:(id)sender {
    [self.centralTextField setFont:[NSFont fontWithName:@"Arial" size:(self.verticalSlider.doubleValue)]];
}

@end
