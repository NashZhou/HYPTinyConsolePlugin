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
    [self xxx_setRootViewController:[TinyConsole createViewController:rootViewController includingDefault:NO]];
}

@end

