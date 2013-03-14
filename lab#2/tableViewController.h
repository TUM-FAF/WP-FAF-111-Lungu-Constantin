#import <Foundation/Foundation.h>
#import "Person.h"

@interface tableViewController : NSObject <NSTableViewDataSource> {
    IBOutlet NSTableView *tableView;
    NSMutableArray *list;
}

- (IBAction)addPressed:(id)sender;
- (IBAction)removePressed:(id)sender;

@end
