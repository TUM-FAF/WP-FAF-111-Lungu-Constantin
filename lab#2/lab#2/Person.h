#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic) int age;

- (void) createPersonWithName:(NSString*)name andAge:(int)age;

@end
