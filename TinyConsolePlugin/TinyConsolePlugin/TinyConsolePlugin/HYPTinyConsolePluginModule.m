#import "HYPTinyConsolePluginModule.h"
#import <HyperioniOS/HYPPluginMenuItem.h>
#import <HyperioniOS/HyperionManager.h>
#import "TinyConsole.h"

@interface HYPTinyConsolePluginModule () <HYPPluginMenuItemDelegate>

@end

@implementation HYPTinyConsolePluginModule
@synthesize pluginMenuItem = _pluginMenuItem;

-(UIView *)pluginMenuItem
{
    if (_pluginMenuItem)
    {
        return _pluginMenuItem;
    }
    
    HYPPluginMenuItem *pluginItem = [HYPPluginMenuItem new];
    pluginItem.delegate = self;
    [pluginItem bindWithTitle:@"Tiny Console" image:[UIImage imageWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"console" ofType:@"png"]]];
    
    _pluginMenuItem = pluginItem;
    
    return _pluginMenuItem;
}

-(void)pluginMenuItemSelected:(UIView<HYPPluginMenuItem> *)pluginView
{
    [_pluginMenuItem setSelected:![[[TinyConsole shared]consoleController]isExpanded] animated:YES];
    // When the plugin is selected, close the plugin drawer and wait 0.5 seconds to toggle the console open
    // If there isn't a delay, the snapshot container will just show the console open and closed without an animation in between
    [[HyperionManager sharedInstance] togglePluginDrawer];
    // Also disable all snapshot plugins
    self.extension.snapshotContainer.overlayModule = nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * (double)NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TinyConsole toggleConsole];
    });
}

@end
