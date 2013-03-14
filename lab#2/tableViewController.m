#import "tableViewController.h"

@implementation tableViewController

-(NSInteger) numberOfRowsInTableView:(NSTableView*) tableView{
    if(!list){
        return 0;
    } else {
    return [list count];
    }
}

- (id)tableView:(NSTableView*)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    Person *p = [list objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    return [p valueForKey:identifier];
}

- (IBAction)addPressed:(id)sender {
    Person *p = [[Person alloc] init];
    if(arc4random()%2 == 0){
    if(arc4random()%2 == 0){
    [p createPersonWithName:@"Yoda" andAge:300];
    } else {
        [p createPersonWithName:@"Darth" andAge:57];
    }
    } else {
        if(arc4random()%2 == 0){
            [p createPersonWithName:@"Luke" andAge:28];
        }
        else {
            [p createPersonWithName:@"R2-D2" andAge:2];
        }
    }
    if(!list){
        list = [NSMutableArray array];
    }
    [list addObject:p];
    [tableView reloadData];
}

- (IBAction)removePressed:(id)sender {
    int selectedRow = [tableView selectedRow];
    [list removeObjectAtIndex:selectedRow];
    [tableView reloadData];
}


@end
