// Objective-C port of Cosmo's TinyConsole

#import <UIKit/UIKit.h>

typedef enum TCAnchor : NSUInteger
{
    TCTop,
    TCBottom
} TCAnchor;

@interface UIView (Attach)

-(void)attachAnchor:(TCAnchor)anchor toView:(UIView *)view;

@end
