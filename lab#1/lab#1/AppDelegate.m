#import "AppDelegate.h"

@implementation AppDelegate

// synthesize every outlet and array

@synthesize fruitTabOne = _fruitTabOne;
@synthesize fruitTabTwo = _fruitTabTwo;
@synthesize fruitFieldOne = _fruitFieldOne;
@synthesize fruitFieldTwo = _fruitFieldTwo;
@synthesize fruitsUserLikes = _fruitsUserLikes;
@synthesize fruitsUserDislikes = _fruitsUserDislikes;
@synthesize allFruits = _allFruits;

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"Application finished launching succesfully.");	
    
    // We have to set the fruit fields (text inputs)
    // target to self, so that when user presses 
    // enter the fruit will be added to the text label
    
    [self.fruitFieldOne setTarget:self];
    [self.fruitFieldTwo setTarget:self];
    [self.fruitFieldOne setAction:@selector(addOne:)];
    [self.fruitFieldTwo setAction:@selector(addTwo:)];
    
    // initiate all permitted fruits
    
    _allFruits = [NSArray arrayWithObjects:@"Apple",@"Apricot",@"Avocado",@"Banana",@"Breadfruit",@"Blackberry",@"Blueberry",@"Cherry",@"Coconut",@"Eggplant",@"Grape",@"Grapefruit",@"Kiwi",@"Lemon",@"Lime",@"Mandarine",@"Mango",@"Melon",@"Orange",@"Peach",@"Pear",@"Pineapple",@"Tomato",@"Watermelon", nil];
    
    _fruitsUserLikes = [NSMutableArray array];
    _fruitsUserDislikes = [NSMutableArray array];
}

- (IBAction)addOne:(id)sender {
    // add the fruit to the first column, if it exists
    NSString *fruitName = [_fruitFieldOne stringValue];
    BOOL fruitExists, fruitAlreadyInList;
    for(NSString *fruit in _allFruits){
        if ([fruit caseInsensitiveCompare:fruitName] == NSOrderedSame) { // if there exists such a fruit
            
            fruitExists = TRUE;
            fruitAlreadyInList = FALSE;
                // find out if the user already likes it
            for(NSString *fruitUserLikes in _fruitsUserLikes){ 
                if([fruitUserLikes caseInsensitiveCompare:fruitName] == NSOrderedSame){ // if user already likes it
                    NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Sorry, that fruit is already in the list."];
                    [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
                    fruitAlreadyInList = TRUE;
                    break;
                    }
                
                }
                // find out if the user already dislikes it
                for(NSString *fruitUserDislikes in _fruitsUserDislikes){
            if([fruitUserDislikes caseInsensitiveCompare:fruit] == NSOrderedSame){ // if user dislikes it
                NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"But you dislike that fruit!"];
                [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
                fruitAlreadyInList = TRUE;
                break;
                }
            }
                
            if(!fruitAlreadyInList){ // if it's not in the list
            NSString *newTab = [NSString stringWithFormat:[_fruitTabOne stringValue]];
            newTab = [newTab stringByAppendingString:@"\n"];
            newTab = [newTab stringByAppendingString:fruitName];
            [_fruitTabOne setStringValue:newTab];
            [_fruitsUserLikes addObject:fruitName]; // add to the likes array
            }
            break;
        }
        else {
            fruitExists = FALSE;   
        }
    }
        if(fruitExists == FALSE){
            NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Sorry, that fruit doesn't exist."];
            [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
        }
}

- (IBAction)addTwo:(id)sender {
    // add the fruit to the second column, if it exists
    NSString *fruitName = [_fruitFieldTwo stringValue];
    BOOL fruitExists, fruitAlreadyInList;
    for(NSString *fruit in _allFruits){
        if ([fruit caseInsensitiveCompare:fruitName] == NSOrderedSame) { // if there exists such a fruit
            
            fruitExists = TRUE;
            fruitAlreadyInList = FALSE;
            // find out if the user already dislikes it
            for(NSString *fruitUserDislikes in _fruitsUserDislikes){ 
                if([fruitUserDislikes caseInsensitiveCompare:fruitName] == NSOrderedSame){ // if user already dislikes it
                    NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Sorry, that fruit is already in the list."];
                    [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
                    fruitAlreadyInList = TRUE;
                    break;
                }
                
            }
            // find out if the user already likes it
            for(NSString *fruitUserLikes in _fruitsUserLikes){
                if([fruitUserLikes caseInsensitiveCompare:fruit] == NSOrderedSame){ // if user dislikes it
                    NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"But you like that fruit!"];
                    [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
                    fruitAlreadyInList = TRUE;
                    break;
                }
            }
            
            if(!fruitAlreadyInList){ // if it's not in the list
                NSString *newTab = [NSString stringWithFormat:[_fruitTabTwo stringValue]];
                newTab = [newTab stringByAppendingString:@"\n"];
                newTab = [newTab stringByAppendingString:fruitName];
                [_fruitTabTwo setStringValue:newTab];
                [_fruitsUserDislikes addObject:fruitName]; // add to the likes array
            }
            break;
        }
        else {
            fruitExists = FALSE;   
        }
    }
    if(fruitExists == FALSE){
        NSAlert *myAlert = [NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Sorry, that fruit doesn't exist."];
        [myAlert beginSheetModalForWindow:_window modalDelegate:nil didEndSelector:nil contextInfo:nil];
    }
}

- (IBAction)clearOne:(id)sender {
    [_fruitTabOne setStringValue:@"Fruits you like:"]; // reset the text label
    _fruitsUserLikes = nil; // reset the array
    _fruitsUserLikes = [NSMutableArray array];
}

- (IBAction)clearTwo:(id)sender {
    [_fruitTabTwo setStringValue:@"Fruits you dislike:"]; // reset the text label
    _fruitsUserDislikes = nil; // reset the array
    _fruitsUserDislikes = [NSMutableArray array];
}
@end
