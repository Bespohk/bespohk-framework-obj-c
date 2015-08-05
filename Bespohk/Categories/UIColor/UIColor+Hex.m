#import "UIColor+Hex.h"

@implementation UIColor (Hex)

#pragma mark ColorSpaceModel

- (CGColorSpaceModel)colorSpaceModel
{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents
{
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

#pragma mark Color based getters

- (CGFloat)red
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[1];
}

- (CGFloat)blue
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[2];
}

#pragma mark Conversion

- (NSString *)toHexString
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color");
    
    CGFloat r, g, b;
    r = self.red;
    g = self.green;
    b = self.blue;
    
    if (r < 0.0f) r = 0.0f;
    if (g < 0.0f) g = 0.0f;
    if (b < 0.0f) b = 0.0f;
    if (r > 1.0f) r = 1.0f;
    if (g > 1.0f) g = 1.0f;
    if (b > 1.0f) b = 1.0f;
    
    return [NSString stringWithFormat:@"%02X%02X%02X",
            (int)(r * 255), (int)(g * 255), (int)(b * 255)];
}

- (NSArray *)toCMYK
{
    const CGFloat *parts = CGColorGetComponents(self.CGColor);
    CGFloat r = parts[0];
    CGFloat g = parts[1];
    CGFloat b = parts[2];
    
    CGFloat k = MIN(1-r,MIN(1-g,1-b));
    CGFloat c = (1.0f-r-k)/(1.0f-k);
    CGFloat m = (1.0f-g-k)/(1.0f-k);
    CGFloat y = (1.0f-b-k)/(1.0f-k);
    
    if (isnan(c)) {
        c = 0;
    }
    if (isnan(m)) {
        m = 0;
    }
    if (isnan(y)) {
        y = 0;
    }
    
    return @[[NSNumber numberWithFloat:c], [NSNumber numberWithFloat:m], [NSNumber numberWithFloat:y], [NSNumber numberWithFloat:k]];
}

- (NSArray *)toRGB
{
    NSScanner* scanner = [NSScanner scannerWithString:self.toHexString];
    unsigned hex;
    int r = 255;
    int g = 255;
    int b = 255;
    if ([scanner scanHexInt:&hex]) {
        r = (hex >> 16) & 0xFF;
        g = (hex >> 8) & 0xFF;
        b = (hex) & 0xFF;
    }
    
    return @[[NSNumber numberWithInt:r], [NSNumber numberWithInt:g], [NSNumber numberWithInt:b]];
}

#pragma mark Initialization

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)opacity
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:opacity];
}

+ (UIColor *)colorWithHexString:(NSString *)hexToConvert
{
    return [UIColor colorWithHexString:hexToConvert alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexToConvert alpha:(CGFloat)opacity
{
    NSString *colorString = [[[hexToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]] uppercaseString];
    
    if ([colorString hasPrefix:@"0X"]) colorString = [colorString substringFromIndex:2];
    
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    
    return [UIColor colorWithRGBHex:hexNum alpha:opacity];
}

# pragma mark Lighten/Darken

- (UIColor *)lighterColor:(CGFloat)amount
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:MIN(s * amount, 1.0)
                          brightness:MIN(b * amount, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColor:(CGFloat)amount
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s * amount
                          brightness:b * amount
                               alpha:a];
    return nil;
}

@end
