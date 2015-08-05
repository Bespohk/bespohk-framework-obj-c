#import <UIKit/UIKit.h>

@interface UIImage (Color)

- (UIColor *)centerColor;
- (UIColor *)centerColorWithRadius:(float)radius;
- (UIColor *)colorAtPoint:(CGPoint)point;
- (UIColor *)colorAtPoint:(CGPoint)point withRadius:(float)radius;
- (UIImage *)imageWithOverlayColor:(UIColor *)color;

@end
