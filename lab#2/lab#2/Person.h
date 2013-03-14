#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic) int age;

- (Person*) createPersonWithName:(NSString*)name andAge:(int)age;

@end
