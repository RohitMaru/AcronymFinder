//
//  DetailsTableViewController.m
//  AcronymFinder
//
//  Created by Rohit Marumamula on 8/7/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import "DetailsTableViewController.h"

@interface DetailsTableViewController ()

@end

@implementation DetailsTableViewController

NSString *cellIdentifer = @"basicCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listOfMeanings.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *variationsList = self.listOfMeanings[section];
    return variationsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    
    NSArray *variationsList = self.listOfMeanings[indexPath.section];
    
    cell.textLabel.text = variationsList[indexPath.row];
    
    return cell;
}

@end
