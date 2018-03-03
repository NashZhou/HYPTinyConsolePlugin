// Objective-C port of Cosmo's TinyConsole

#import "TinyConsoleViewController.h"
#import "TinyConsole.h"

@implementation TinyConsoleViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupConsoleTextView];
    [[TinyConsole shared]setTextView:self.consoleTextView];
    [self.view addSubview:_consoleTextView];
    [self setupConstraints];
}

-(void)setupConsoleTextView
{
    _consoleTextView = [UITextView new];
    _consoleTextView.backgroundColor = [UIColor blackColor];
    _consoleTextView.editable = NO;
}

-(void)setupConstraints
{
    self.consoleTextView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 9, *))
    {
        [self.consoleTextView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
        [self.consoleTextView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
        [self.consoleTextView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
        [self.consoleTextView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    }
    else
    {
        [NSLayoutConstraint constraintWithItem:self.consoleTextView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.consoleTextView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.consoleTextView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.consoleTextView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0].active = YES;
    }
}

-(void)customText:(UITapGestureRecognizer *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Custom Log" message:@"Enter text you want to log." preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeAlphabet;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Add log" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (alert.textFields.firstObject.text && ![alert.textFields.firstObject.text  isEqual: @""])
       {
           [TinyConsole printText:alert.textFields.firstObject.text];
       }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction: okAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)useDefaultGestureConfiguration
{
    if (self.view.gestureRecognizers)
    {
        for (UIGestureRecognizer *gestureRecognizer in self.view.gestureRecognizers)
        {
            [self.view removeGestureRecognizer:gestureRecognizer];
        }
    }
    
    UISwipeGestureRecognizer *addMarkerGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(addMarker:)];
    [self.view addGestureRecognizer:addMarkerGesture];
    
    UITapGestureRecognizer *addCustomTextGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customText:)];
    addCustomTextGesture.numberOfTouchesRequired = 2;
    if (@available(iOS 9, *))
    {
        [self.view addGestureRecognizer:addCustomTextGesture];
    }
    else
    {
        [self.consoleTextView addGestureRecognizer:addCustomTextGesture];
    }
    
    UITapGestureRecognizer *showAdditionalActionsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(additionalActions:)];
    showAdditionalActionsGesture.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:showAdditionalActionsGesture];
}

-(void)additionalActions:(UITapGestureRecognizer *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *defaultActions = @[[UIAlertAction actionWithTitle:@"Send Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
           if ([[TinyConsole shared]textView])
           {
               MFMailComposeViewController *composeViewController = [MFMailComposeViewController new];
               composeViewController.mailComposeDelegate = self;
               [composeViewController setSubject:@"Console Log"];
               [composeViewController setMessageBody:[[TinyConsole shared]textView].text isHTML:NO];
           }
        });
    }], [UIAlertAction actionWithTitle:@"Clear" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [TinyConsole clear];
    }]];
    
    for (UIAlertAction *action in defaultActions)
    {
        [alert addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)addMarker:(UISwipeGestureRecognizer *)sender
{
    [TinyConsole addMarker];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
