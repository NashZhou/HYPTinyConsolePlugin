// Objective-C port of Cosmo's TinyConsole

#import <UIKit/UIKit.h>
#import "TinyConsoleViewController.h"

typedef enum TCWindowMode : NSUInteger
{
    TCCollapsed,
    TCExpanded
} TCWindowMode;


@interface TinyConsoleController : UIViewController

@property (nonatomic, strong) TinyConsoleViewController *consoleViewController;
@property (nonatomic, strong) NSLayoutConstraint *consoleViewHeightConstraint;
@property (nonatomic, weak) UIViewController *rootViewController;

-(BOOL)isExpanded;
-(void)toggleConsole;

@end
