//
//  UIWindow+TinyConsoleSwizzle.m
//  TinyConsoleObjC
//
//  Created by Nash Zhou on 3/3/18.
//  Copyright © 2018 nashzhou. All rights reserved.
//

#import "UIWindow+TinyConsoleSwizzle.h"
#import "TinyConsole.h"
#import <objc/runtime.h>

@implementation UIWindow (TinyConsoleSwizzle)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(setRootViewController:);
        SEL swizzledSelector = @selector(xxx_setRootViewController:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));

        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

-(void)xxx_setRootViewController:(UIViewController *)rootViewController
{
    // TinyConsole should only attach to the rootViewController the second time this function is called
    // (This isn't the most efficient way to detect if setRootViewController has been called twice)
    if ([[TinyConsole shared]guarded])
    {
        [self xxx_setRootViewController:rootViewController];
    }
    else if (![[TinyConsole shared]assigned])
    {
        [self xxx_setRootViewController:rootViewController];
        [[TinyConsole shared]setAssigned:YES];
    }
    else
    {
        [self xxx_setRootViewController:[TinyConsole createViewController:rootViewController includingDefault:NO]];
        [TinyConsole printText:@"Welcome to TinyConsole"];
        [TinyConsole addMarker];
        [TinyConsole printText:@"NOW" withColor:[UIColor redColor]];
        [TinyConsole printText:@"IN" withColor:[UIColor greenColor]];
        [TinyConsole printText:@"COLOR" withColor:[UIColor blueColor]];
        [TinyConsole addMarker];
        [[TinyConsole shared]setGuarded:YES];
    }
}

@end

