//
//  UIViewController+ProgressHUD.m
//  AcronymFinder
//
//  Created by Rohit Marumamula on 8/13/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import "UIViewController+ProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIViewController (ProgressHUD)

MBProgressHUD *progressHUD;

-(void)showSpinner {
    if (progressHUD == nil) {
        progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        progressHUD.backgroundView.color = [UIColor blackColor];
        progressHUD.backgroundView.alpha = 0.6;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [progressHUD showAnimated:YES];
    });
}

-(void)hideSpinner {
    dispatch_async(dispatch_get_main_queue(), ^{
        [progressHUD hideAnimated:YES];
    });
}

@end
