#import <Foundation/Foundation.h>
#import "NSObject+NullUnwrapping.h"

@implementation NSObject (NullUnwrapping)

- (id)valueOrNil
{
    return self;
}

@end

@implementation NSNull (NullUnwrapping)

- (id)valueOrNil
{
    return nil;
}

@end