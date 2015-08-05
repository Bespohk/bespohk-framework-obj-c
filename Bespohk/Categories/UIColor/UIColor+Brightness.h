#import <UIKit/UIKit.h>

typedef enum
{
    UIColorBrightnessLight,
    UIColorBrightnessDark
} UIColorBrightness;

@interface UIColor (Brightness)

- (UIColorBrightness)brightness;

@end
