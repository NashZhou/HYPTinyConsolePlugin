// Objective-C port of Cosmo's TinyConsole

#import "UIView+Attach.h"

@implementation UIView (Attach)

-(void)attachAnchor:(TCAnchor)anchor toView:(UIView *)view
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 9, *))
    {
        switch (anchor) {
            case TCTop:
                [self.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
                break;
            case TCBottom:
                [self.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
                break;
            default:
                break;
        }
        
        [self.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
        [self.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    }
    else
    {
        switch (anchor) {
            case TCTop:
                [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0].active = YES;
                break;
            case TCBottom:
                [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0].active = YES;
                break;
            default:
                break;
        }
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0].active = YES;
    }
}

@end
