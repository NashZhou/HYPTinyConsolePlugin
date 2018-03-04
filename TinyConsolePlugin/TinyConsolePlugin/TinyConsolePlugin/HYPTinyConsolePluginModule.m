#import "HYPTinyConsolePluginModule.h"
#import <HyperionCore/HYPPluginMenuItem.h>
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
    [TinyConsole toggleConsole];
}

@end
