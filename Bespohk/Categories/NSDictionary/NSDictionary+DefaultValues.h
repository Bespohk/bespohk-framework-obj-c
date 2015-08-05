#import <Foundation/Foundation.h>

@interface NSDictionary (DefaultValues)

- (id)get:(NSString *)key or:(id)defaultValue;

@end
