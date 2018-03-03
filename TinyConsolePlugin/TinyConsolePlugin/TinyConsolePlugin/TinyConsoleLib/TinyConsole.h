// Objective-C port of Cosmo's TinyConsole

#import <UIKit/UIKit.h>
#import "TinyConsoleController.h"

@interface TinyConsole : NSObject

@property (nonatomic, strong) TinyConsoleController *consoleController;
@property (nonatomic, strong) UITextView *textView;

+(id)shared;
+(UIViewController *)createViewController:(UIViewController *)rootViewController;
+(UIViewController *)createViewController:(UIViewController *)rootViewController includingDefault:(BOOL)withDefaultGestureRecognition;
+(void)setRootViewController:(UIViewController *)newRootViewController;
+(void)scrollToBottom;

+(void)printText:(NSString *)text;
+(void)printText:(NSString *)text withColor:(UIColor *)color;
+(void)printText:(NSString *)text withColor:(UIColor *)color andGlobal:(BOOL)global;
+(void)printText:(NSAttributedString *)text andGlobal:(BOOL)global;

+(void)clear;
+(void)error:(NSString *)text;
+(void)addMarker;

+(void)useDefaultGestureConfiguration;
+(void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
+(void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

@end
