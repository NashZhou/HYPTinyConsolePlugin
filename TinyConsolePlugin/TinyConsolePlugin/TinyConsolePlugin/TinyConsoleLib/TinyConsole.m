// Objective-C port of Cosmo's TinyConsole

#import "TinyConsole.h"

@implementation TinyConsole
{
    NSDateFormatter *dateFormatter;
}

static TinyConsole *instance = nil;

+(NSDictionary *)textAppearance
{
    UIFont* font = [UIFont fontWithName:@"Menlo" size:12.0];
    NSDictionary *dict = @{NSFontAttributeName:font, NSForegroundColorAttributeName: [UIColor whiteColor]};
    return dict;
}

+(id)shared
{
    if (instance == nil)
    {
        instance = [TinyConsole new];
    }
    return instance;
}

-(id)init
{
    if (self = [super init])
    {
        self.consoleController = [[TinyConsoleController alloc] init];
        [self setupDateFormatter];
    }
    return self;
}

-(void)setupDateFormatter
{
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
}

-(NSString*)currentTimeStamp
{
    return [dateFormatter stringFromDate:[[NSDate alloc] init]];
}

+(UIViewController *)createViewController:(UIViewController *)rootViewController
{
    return [TinyConsole createViewController:rootViewController includingDefault:YES];
}

+(UIViewController *)createViewController:(UIViewController *)rootViewController includingDefault:(BOOL)withDefaultGestureRecognition
{
    [self setRootViewController:rootViewController];
    if (withDefaultGestureRecognition)
    {
        [TinyConsole useDefaultGestureConfiguration];
    }
    return [[TinyConsole shared]consoleController];

}

+(void)setRootViewController:(UIViewController *)rootViewController
{
    [[[TinyConsole shared]consoleController]setRootViewController:rootViewController];
}

+(void)scrollToBottom
{
    UITextView* textView = [[TinyConsole shared]textView];
    if (textView &&
        textView.bounds.size.height < textView.contentSize.height)
    {
        [textView.layoutManager ensureLayoutForTextContainer:textView.textContainer];
        CGPoint offset = CGPointMake(0, textView.contentSize.height - textView.frame.size.height);
        [textView setContentOffset:offset animated:YES];
    }
}

+(void)printText:(NSString *)text
{
    [TinyConsole printText:text withColor:[UIColor whiteColor] andGlobal:YES];
}

+(void)printText:(NSString *)text withColor:(UIColor *)color
{
    [TinyConsole printText:text withColor:color andGlobal:YES];
}

+(void)printText:(NSString *)text withColor:(UIColor *)color andGlobal:(BOOL)global
{
    NSMutableAttributedString *formattedText = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, formattedText.length);
    
    [formattedText addAttributes:[TinyConsole textAppearance] range:range];
    [formattedText addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    [TinyConsole printText:formattedText andGlobal:global];
}

+(void)printText:(NSAttributedString *)text andGlobal:(BOOL)global
{
    UITextView* textView = [[TinyConsole shared]textView];
    if (textView)
    {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            NSMutableAttributedString *timeStamped = [[NSMutableAttributedString alloc] initWithString:[[[TinyConsole shared]currentTimeStamp] stringByAppendingString: @" "]];
            NSRange range = NSMakeRange(0, timeStamped.length);
            
            [timeStamped addAttributes:[TinyConsole textAppearance] range:range];
            
            [timeStamped appendAttributedString:text];
            [timeStamped appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            
            NSMutableAttributedString *newText = [[NSMutableAttributedString alloc]initWithAttributedString:textView.attributedText];
            [newText appendAttributedString:timeStamped];
            
            textView.attributedText = newText;
            [TinyConsole scrollToBottom];
        });
    }
    
    if (global)
    {
        printf("%s\n", [[text string] UTF8String]);
    }
}

+(void)clear
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        UITextView *textView = [[TinyConsole shared] textView];
        if (textView)
        {
            textView.text = @"";
        }
        [TinyConsole scrollToBottom];
    });
}

+(void)error:(NSString *)text
{
    [TinyConsole printText:text withColor:[UIColor redColor]];
}

+(void)addMarker
{
    [TinyConsole error:@"-----------"];
}

+(void)useDefaultGestureConfiguration
{
    [[[TinyConsole shared]consoleController].consoleViewController useDefaultGestureConfiguration];
}

+(void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    [[[TinyConsole shared]consoleController].consoleViewController.view addGestureRecognizer:gestureRecognizer];
}

+(void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    [[[TinyConsole shared]consoleController].consoleViewController.view removeGestureRecognizer:gestureRecognizer];
}

@end
