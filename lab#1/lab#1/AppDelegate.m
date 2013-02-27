#import "AppDelegate.h"

@implementation AppDelegate
@synthesize fruitTabOne = _fruitTabOne;
@synthesize fruitTabTwo = _fruitTabTwo;
@synthesize fruitFieldOne = _fruitFieldOne;
@synthesize fruitFieldTwo = _fruitFieldTwo;

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"Application finished launching succesfully.");	
    [self.fruitFieldOne setTarget:self];
    [self.fruitFieldTwo setTarget:self];
    [self.fruitFieldOne setAction:@selector(addOne:)];
    [self.fruitFieldTwo setAction:@selector(addTwo:)];
}

- (IBAction)addOne:(id)sender {
    NSLog(@"Should add one");
}

- (IBAction)addTwo:(id)sender {
    NSLog(@"Should add two");
}

- (IBAction)clearOne:(id)sender {
    NSLog(@"Should clear one");
}

- (IBAction)clearTwo:(id)sender {
    NSLog(@"Should clear two");
}
@end
