#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

// declare the outlets

@property (weak) IBOutlet NSTextField *fruitTabOne;
@property (weak) IBOutlet NSTextField *fruitTabTwo;
@property (weak) IBOutlet NSTextField *fruitFieldOne;
@property (weak) IBOutlet NSTextField *fruitFieldTwo;

// declare the arrays which will hold strings, the fruits that user likes or dislikes

@property (strong, nonatomic) NSMutableArray *fruitsUserLikes;
@property (strong, nonatomic) NSMutableArray *fruitsUserDislikes;

// declare the array that will hold all the possible fruits in the application

@property (strong, nonatomic) NSArray *allFruits;

// declare the actions - add to the first column, second, and also clear the first and the second column

- (IBAction)addOne:(id)sender;
- (IBAction)addTwo:(id)sender;
- (IBAction)clearOne:(id)sender;
- (IBAction)clearTwo:(id)sender;

@end
