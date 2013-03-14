#import "Person.h"

@implementation Person

@synthesize name = _name;
@synthesize age = _age;

-(void) createPersonWithName:(NSString *)name andAge:(int)age{
    _name = [NSString stringWithFormat:name];
    _age = age;
}

@end
