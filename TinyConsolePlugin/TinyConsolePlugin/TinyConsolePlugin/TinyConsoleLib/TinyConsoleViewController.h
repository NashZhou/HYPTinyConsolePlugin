// Objective-C port of Cosmo's TinyConsole

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface TinyConsoleViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UITextView *consoleTextView;
-(void)customText:(UITapGestureRecognizer *)sender;
-(void)useDefaultGestureConfiguration;
-(void)additionalActions:(UITapGestureRecognizer *)sender;
-(void)addMarker:(UISwipeGestureRecognizer *)sender;

@end
