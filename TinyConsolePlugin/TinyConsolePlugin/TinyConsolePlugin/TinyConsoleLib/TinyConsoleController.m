// Objective-C port of Cosmo's TinyConsole

#import "TinyConsoleController.h"
#import "TinyConsoleViewController.h"
#import "TinyConsole.h"
#import "UIView+Attach.h"

@interface TinyConsoleController()

@property (nonatomic) CGFloat consoleFrameHeight;
@property (nonatomic) CGFloat expandedHeight;
@property (nonatomic) CGRect consoleFrame;

@end

@implementation TinyConsoleController
{
    TCWindowMode _consoleWindowMode;
}

-(id)init
{
    if (self = [super init])
    {
        _rootViewController = [UIViewController new];
        _consoleViewController = [TinyConsoleViewController new];
        _consoleFrameHeight = 120;
        _expandedHeight = 140;
        _consoleWindowMode = TCCollapsed;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewControllers];
    [self setupConstraints];
}

-(BOOL)isExpanded
{
    return self.consoleWindowMode == TCExpanded;
}

-(void)setRootViewController:(UIViewController *)rootViewController
{
    _rootViewController = rootViewController;
    [self setupViewControllers];
    [self setupConstraints];
}

-(NSLayoutConstraint *)consoleViewHeightConstraint
{
    if (_consoleViewHeightConstraint == nil)
    {
        if (@available(iOS 9, *))
        {
            _consoleViewHeightConstraint = [self.consoleViewController.view.heightAnchor constraintEqualToConstant:0];
        }
        else
        {
            _consoleViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.consoleViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
        }
    }
    return _consoleViewHeightConstraint;
}

-(CGRect)consoleFrame
{
    if (CGRectEqualToRect(_consoleFrame, CGRectZero))
    {
        CGRect frame = self.view.bounds;
        frame.size.height -= self.consoleFrameHeight;

        _consoleFrame = frame;
    }
    return _consoleFrame;
}

-(TCWindowMode)consoleWindowMode
{
    return _consoleWindowMode;
}

-(void)setConsoleWindowMode:(TCWindowMode)consoleWindowMode
{
    _consoleWindowMode = consoleWindowMode;
    
    if (self.consoleViewHeightConstraint)
    {
        _consoleViewHeightConstraint.active = NO;
        _consoleViewHeightConstraint.constant = !self.isExpanded ? 0 : self.expandedHeight;
        _consoleViewHeightConstraint.active = YES;
    }
}

//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    if (motion == UIEventSubtypeMotionShake)
//    {
//        self.consoleWindowMode = !self.isExpanded ? TCExpanded : TCCollapsed;
//        [UIView animateWithDuration:0.25 animations:^(void) {
//            [self.view layoutIfNeeded];
//        }];
//    }
//}

// Replacement for the shake gesture
-(void)toggleConsole
{
    self.consoleWindowMode = !self.isExpanded ? TCExpanded : TCCollapsed;
    [UIView animateWithDuration:0.25 animations:^(void) {
        [self.view layoutIfNeeded];
    }];
}

-(void)setupViewControllers
{
    for (UIView *view in self.view.subviews)
    {
        [view removeFromSuperview];
    }
    
    for (UIViewController *childViewController in self.childViewControllers)
    {
        [childViewController removeFromParentViewController];
    }
    
    [self addChildViewController:_consoleViewController];
    self.consoleViewController.view.frame = self.consoleFrame;
    [self.view addSubview:_consoleViewController.view];
    [self.consoleViewController didMoveToParentViewController:self];
    
    [self addChildViewController:_rootViewController];
    [self.rootViewController.view setFrame:CGRectMake(CGRectGetMinX(_consoleFrame), CGRectGetMaxY(_consoleFrame), self.view.bounds.size.width, 120)];
    [self.view addSubview:_rootViewController.view];
    [self.rootViewController didMoveToParentViewController:self];
}

-(void)setupConstraints
{
    [_rootViewController.view attachAnchor:TCTop toView:self.view];
    
    [_consoleViewController.view attachAnchor:TCBottom toView:self.view];
    if (_consoleViewHeightConstraint)
    {
        _consoleViewHeightConstraint.active = YES;
    }
    
    if (@available(iOS 9, *))
    {
        [_rootViewController.view.bottomAnchor constraintEqualToAnchor:self.consoleViewController.view.topAnchor].active = YES;
    }
    else
    {
        [NSLayoutConstraint constraintWithItem:self.rootViewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.consoleViewController.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0].active = YES;
    }
}


@end
