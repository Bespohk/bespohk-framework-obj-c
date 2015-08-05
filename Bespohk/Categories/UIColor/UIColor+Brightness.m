#import "UIColor+Brightness.h"

@implementation UIColor (Brightness)

- (UIColorBrightness)brightness
{
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    
    if (colorBrightness < 0.5) {
        return UIColorBrightnessDark;
    }
    else {
        return UIColorBrightnessLight;
    }
}

@end

