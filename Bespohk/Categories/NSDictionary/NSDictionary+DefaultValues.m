#import "NSDictionary+DefaultValues.h"
#import "NSObject+NullUnwrapping.h"

@implementation NSDictionary (DefaultValues)

- (id)get:(NSString *)key or:(id)defaultValue
{
    id value = [self[key] valueOrNil];
    if (!value) {
        return defaultValue;
    }
    
    return value;
}

@end
