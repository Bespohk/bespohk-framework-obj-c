#import "UIImage+Color.h"

@implementation UIImage (Color)

- (UIColor *)centerColor
{
    return [self centerColorWithRadius:1];
}

- (UIColor *)centerColorWithRadius:(float)radius
{
    CGPoint point = CGPointMake(self.size.width / 2, self.size.height / 2);
    UIColor *color = [self colorAtPoint:point withRadius:radius];
    
    return color;
}

- (UIColor *)colorAtPoint:(CGPoint)point
{
    return [self colorAtPoint:point withRadius:1];
}

- (UIColor *)colorAtPoint:(CGPoint)point withRadius:(float)radius
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    int radiusSize = ceilf(radius / 2);
    
    int xStartPoint = point.x - radiusSize;
    int yStartPoint = point.y - radiusSize;
    if (radius == 0) {
        radius = 1;
    }
    CGRect rect = CGRectMake(xStartPoint, yStartPoint, radius, radius);
    
    CGImageRef rawImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), rawImageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    UIColor *color;
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        color = [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        color = [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
    CGImageRelease(rawImageRef);
    return color;
}

- (UIColor *)colorAtPoint2:(CGPoint)point withRadius:(float)radius
{
    int radiusSize = ceilf(radius / 2);
    
    int xStartPoint = point.x - radiusSize;
    int yStartPoint = point.y - radiusSize;
    if (radius == 0) {
        radius = 1;
    }
    CGRect rect = CGRectMake(xStartPoint, yStartPoint, radius, radius);
    
    CGImageRef rawImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(rawImageRef));
    const UInt8 *rawPixelData = CFDataGetBytePtr(data);
    
    NSUInteger imageHeight = CGImageGetHeight(rawImageRef);
    NSUInteger imageWidth  = CGImageGetWidth(rawImageRef);
    NSUInteger bytesPerRow = CGImageGetBytesPerRow(rawImageRef);
    NSUInteger stride = CGImageGetBitsPerPixel(rawImageRef) / 8;
    
    unsigned int red   = 0;
    unsigned int green = 0;
    unsigned int blue  = 0;
    
    for (int row = 0; row < imageHeight; row++) {
        const UInt8 *rowPtr = rawPixelData + bytesPerRow * row;
        for (int column = 0; column < imageWidth; column++) {
            red += rowPtr[0];
            green += rowPtr[1];
            blue += rowPtr[2];
            rowPtr += stride;
        }
    }
    CFRelease(data);
    CGImageRelease(rawImageRef);

    CGFloat f = 1.0f / (255.0f * imageWidth * imageHeight);
    return [UIColor colorWithRed:f * red green:f * green blue:f * blue alpha:1];
}

- (UIImage *)imageWithOverlayColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    if (UIGraphicsBeginImageContextWithOptions) {
        CGFloat imageScale = 1.0f;
        if ([self respondsToSelector:@selector(scale)]) {
            imageScale = self.scale;
        }
        UIGraphicsBeginImageContextWithOptions(self.size, NO, imageScale);
    }
    
    [self drawInRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
