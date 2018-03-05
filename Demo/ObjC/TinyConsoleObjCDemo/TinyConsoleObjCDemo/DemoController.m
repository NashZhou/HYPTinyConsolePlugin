//
//  DemoController.m
//  TinyConsoleObjCDemo
//
//  Created by Nash Zhou on 3/5/18.
//  Copyright © 2018 nashzhou. All rights reserved.
//

#import "DemoController.h"

#if DEBUG
#import <TinyConsolePlugin/TinyConsole.h>
#endif

@implementation DemoController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Adding a button to the screen
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Click me" forState:UIControlStateNormal];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    [NSLayoutConstraint activateConstraints:@[[btn.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [btn.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [btn.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [btn.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]]];
}

-(void)btnPressed:(UIButton *)sender
{
    // Print to the console
#if DEBUG
    [TinyConsole printText:@"Hello Console"];
#endif
}

@end
