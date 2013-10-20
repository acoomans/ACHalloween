//
//  ACTableViewController.m
//  ACHalloweenDemo
//
//  Created by Arnaud Coomans on 10/19/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACTableViewController.h"
#import "ACGlowingLabelViewController.h"
#import "ACFingerprintViewController.h"
#import "ACBloodtrailViewController.h"


@interface ACTableViewController ()
@property (nonatomic, strong) NSArray *children;
@end

@implementation ACTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Halloween";

    self.children = @[
                      ACGlowingLabelViewController.class,
                      ACFingerprintViewController.class,
                      ACBloodtrailViewController.class,
                      ];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.children count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    Class viewControllerClass = self.children[indexPath.row];
    cell.textLabel.text = NSStringFromClass(viewControllerClass);
    cell.textLabel.textColor = [UIColor halloweenColor];

    cell.backgroundColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class viewControllerClass = self.children[indexPath.row];
    UIViewController *childViewController = [[viewControllerClass alloc] initWithNibName:NSStringFromClass(viewControllerClass) bundle:nil];

    [self.navigationController pushViewController:childViewController animated:YES];
}

@end
