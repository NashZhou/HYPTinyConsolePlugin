//
//  HYPTinyConsolePlugin.m
//  TinyConsole
//
//  Created by Nash Zhou on 3/2/18.
//  Copyright © 2018 WillowTree. All rights reserved.
//

#import "HYPTinyConsolePlugin.h"
#import "HYPTinyConsolePluginModule.h"

@implementation HYPTinyConsolePlugin

+(id<HYPPluginModule>)createPluginModule:(id<HYPPluginExtension>)pluginExtension
{
    return [[HYPTinyConsolePluginModule alloc] initWithExtension:pluginExtension];
}

+(NSString *)pluginVersion
{
    return [[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}

@end
