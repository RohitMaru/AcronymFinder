//
//  ViewController.h
//  AcronymFinder
//
//  Created by Rohit Marumamula on 8/7/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//Made them public to unit test it..
-(NSArray *) parseResponse:(NSArray *)response;

@end

