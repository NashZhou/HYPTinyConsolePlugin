using Foundation;
using MessageUI;
using ObjCRuntime;
using UIKit;

namespace TinyConsolePlugin
{
    // @interface TinyConsoleViewController : UIViewController <MFMailComposeViewControllerDelegate>
    [BaseType(typeof(UIViewController))]
    interface TinyConsoleViewController : IMFMailComposeViewControllerDelegate
    {
        // @property (nonatomic, strong) UITextView * consoleTextView;
        [Export("consoleTextView", ArgumentSemantic.Strong)]
        UITextView ConsoleTextView { get; set; }

        // -(void)customText:(UITapGestureRecognizer *)sender;
        [Export("customText:")]
        void CustomText(UITapGestureRecognizer sender);

        // -(void)useDefaultGestureConfiguration;
        [Export("useDefaultGestureConfiguration")]
        void UseDefaultGestureConfiguration();

        // -(void)additionalActions:(UITapGestureRecognizer *)sender;
        [Export("additionalActions:")]
        void AdditionalActions(UITapGestureRecognizer sender);

        // -(void)addMarker:(UISwipeGestureRecognizer *)sender;
        [Export("addMarker:")]
        void AddMarker(UISwipeGestureRecognizer sender);
    }

    // @interface TinyConsoleController : UIViewController
    [BaseType(typeof(UIViewController))]
    interface TinyConsoleController
    {
        // @property (nonatomic, strong) TinyConsoleViewController * consoleViewController;
        [Export("consoleViewController", ArgumentSemantic.Strong)]
        TinyConsoleViewController ConsoleViewController { get; set; }

        // @property (nonatomic, strong) NSLayoutConstraint * consoleViewHeightConstraint;
        [Export("consoleViewHeightConstraint", ArgumentSemantic.Strong)]
        NSLayoutConstraint ConsoleViewHeightConstraint { get; set; }

        // @property (nonatomic, strong) UIViewController * rootViewController;
        [Export("rootViewController", ArgumentSemantic.Weak)]
        UIViewController RootViewController { get; set; }

        // -(BOOL)isExpanded;
        [Export("isExpanded")]
        // [Verify (MethodToProperty)]
        bool IsExpanded { get; }

        // -(void)toggleConsole;
        [Export("toggleConsole")]
        void ToggleConsole();
    }

    // @interface TinyConsole : NSObject
    [BaseType(typeof(NSObject))]
    interface TinyConsole
    {
        // @property (nonatomic, strong) TinyConsoleController * consoleController;
        [Export("consoleController", ArgumentSemantic.Strong)]
        TinyConsoleController ConsoleController { get; set; }

        // @property (nonatomic, strong) UITextView * textView;
        [Export("textView", ArgumentSemantic.Strong)]
        UITextView TextView { get; set; }

        // +(id)shared;
        [Static]
        [Export("shared")]
        // [Verify (MethodToProperty)]
        NSObject Shared { get; }

        // +(UIViewController *)createViewController:(UIViewController *)rootViewController;
        [Static]
        [Export("createViewController:")]
        UIViewController CreateViewController(UIViewController rootViewController);

        // +(UIViewController *)createViewController:(UIViewController *)rootViewController includingDefault:(BOOL)withDefaultGestureRecognition;
        [Static]
        [Export("createViewController:includingDefault:")]
        UIViewController CreateViewController(UIViewController rootViewController, bool withDefaultGestureRecognition);

        // +(void)setRootViewController:(UIViewController *)newRootViewController;
        [Static]
        [Export("setRootViewController:")]
        void SetRootViewController(UIViewController newRootViewController);

        // +(void)scrollToBottom;
        [Static]
        [Export("scrollToBottom")]
        void ScrollToBottom();

        // +(void)printText:(NSString *)text;
        [Static]
        [Export("printText:")]
        void PrintText(string text);

        // +(void)printText:(NSString *)text withColor:(UIColor *)color;
        [Static]
        [Export("printText:withColor:")]
        void PrintText(string text, UIColor color);

        // +(void)printText:(NSString *)text withColor:(UIColor *)color andGlobal:(BOOL)global;
        [Static]
        [Export("printText:withColor:andGlobal:")]
        void PrintText(string text, UIColor color, bool global);

        // +(void)printText:(NSAttributedString *)text andGlobal:(BOOL)global;
        [Static]
        [Export("printText:andGlobal:")]
        void PrintText(NSAttributedString text, bool global);

        // +(void)clear;
        [Static]
        [Export("clear")]
        void Clear();

        // +(void)error:(NSString *)text;
        [Static]
        [Export("error:")]
        void Error(string text);

        // +(void)addMarker;
        [Static]
        [Export("addMarker")]
        void AddMarker();

        // +(void)useDefaultGestureConfiguration;
        [Static]
        [Export("useDefaultGestureConfiguration")]
        void UseDefaultGestureConfiguration();

        // +(void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
        [Static]
        [Export("addGestureRecognizer:")]
        void AddGestureRecognizer(UIGestureRecognizer gestureRecognizer);

        // +(void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
        [Static]
        [Export("removeGestureRecognizer:")]
        void RemoveGestureRecognizer(UIGestureRecognizer gestureRecognizer);

        // +(void)toggleConsole;
        [Static]
        [Export("toggleConsole")]
        void ToggleConsole();
    }

    // @interface Attach (UIView)
    [Category]
    [BaseType(typeof(UIView))]
    interface UIView_Attach
    {
        // -(void)attachAnchor:(TCAnchor)anchor toView:(UIView *)view;
        [Export("attachAnchor:toView:")]
        void AttachAnchor(TCAnchor anchor, UIView view);
    }
}