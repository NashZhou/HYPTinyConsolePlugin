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
    self.title = @"Demo";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#if DEBUG
    [TinyConsole printText:[NSString stringWithFormat:@"Tapped on %ld", (long)indexPath.row]];
#endif
}

@end
