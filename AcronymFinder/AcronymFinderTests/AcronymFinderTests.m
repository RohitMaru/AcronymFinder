//
//  AcronymFinderTests.m
//  AcronymFinderTests
//
//  Created by Rohit Marumamula on 8/7/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "DetailsTableViewController.h"
#import "AFParser.h"

@interface AcronymFinderTests : XCTestCase

@end

@implementation AcronymFinderTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testIfNavigationControllerExists {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController = (UINavigationController *)[storyBoard instantiateInitialViewController];
    XCTAssertNotNil(navController);
}

-(void)testIfViewControllerExists {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController = (UINavigationController *)[storyBoard instantiateInitialViewController];
    ViewController *vc = (ViewController *)navController.topViewController;
    XCTAssertNotNil(vc);
}

-(void)testIfParseResponseThrowsNil {
    XCTAssertNotNil([AFParser parseResponse:nil]);
}

-(void) testIfDetailsVCExists {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsTableViewController *detailsVC = (DetailsTableViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"detailsVCIdentifier"];
    XCTAssertNotNil(detailsVC);
}

@end
