//
//  ViewController.m
//  AcronymFinder
//
//  Created by Rohit Marumamula on 8/7/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import "ViewController.h"
#import "DetailsTableViewController.h"
#import "UIViewController+ProgressHUD.h"
#import "AFServicesHandler.h"
#import "AFParser.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *acronymTxtFld;

@end

@implementation ViewController

NSString *segueIdentifier = @"detailsVCIdentifier";
NSString *urlString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.acronymTxtFld.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

-(void) viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)submitAction:(UIButton *)sender {
    
    NSString *acronym = self.acronymTxtFld.text;
    if (acronym.length > 0) {
        [self showSpinner];

        __weak ViewController *weakSelf = self;
        AFServicesHandler *serviceHandler = [[AFServicesHandler alloc] init];
        
        NSDictionary *params = @{@"sf" : acronym};
        [serviceHandler performServiceCallWithURL:urlString andParameters:params onSuccess:^(id responseObject) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *responseArray = (NSArray *)responseObject;
                NSArray *meanings = [AFParser parseResponse:responseArray];
                [weakSelf hideSpinner];
                
                if (meanings.count > 0) {
                    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    DetailsTableViewController *detailsVC = [storyBoard instantiateViewControllerWithIdentifier:segueIdentifier];
                    detailsVC.listOfMeanings = meanings;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController pushViewController:detailsVC animated:YES];
                    });
                } else {
                    [weakSelf presentAlert:@"No meanings found for this acronym/initialism" onVC:weakSelf];
                }
            }

        } onFailure:^(NSError *error) {
            NSString *description = error.localizedDescription;
            if (description == nil || description.length == 0) {
                description = @"Please try later";
            }
            [weakSelf hideSpinner];
            
            [weakSelf presentAlert:description onVC:weakSelf];
        }];
        
    } else {
        [self presentAlert:@"Please enter an acronym"];
    }
    
}

-(void) presentAlert:(NSString *)alertMsg {
    [self presentAlert:alertMsg onVC:self];
}

-(void)presentAlert:(NSString *)alertMsg onVC:(UIViewController *)vc{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:alertController animated:YES completion:nil];
    });
}

@end
