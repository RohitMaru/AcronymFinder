//
//  ViewController.m
//  AcronymFinder
//
//  Created by Rohit Marumamula on 8/7/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import "ViewController.h"
#import "DetailsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

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
        __weak ViewController *weakSelf = self;
        MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressHUD.backgroundView.color = [UIColor blackColor];
        progressHUD.backgroundView.alpha = 0.6;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        
        NSDictionary *params = @{@"sf" : acronym};
        
        [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *responseArray = (NSArray *)responseObject;
                NSArray *meanings = [self parseResponse:responseArray];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                });
                
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
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *description = error.localizedDescription;
            if (description == nil || description.length == 0) {
                description = @"Please try later";
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            });
            
            [weakSelf presentAlert:description onVC:weakSelf];
        }];
    } else {
        [self presentAlert:@"Please enter an acronym"];
    }
    
}

-(NSArray *) parseResponse:(NSArray *)response {
    NSMutableArray *finalMeaningsList = [NSMutableArray array];
    
    for (NSDictionary *fullFormsDict in response) {
        id fullforms = fullFormsDict[@"lfs"];
        if ([fullforms isKindOfClass:[NSArray class]]) {
            NSArray *fullformsList = (NSArray *)fullforms;
            for (NSDictionary *varsDict in fullformsList) {
                id vars = varsDict[@"vars"];
                NSMutableArray *meaningsList = [NSMutableArray array];
                if ([vars isKindOfClass:[NSArray class]]) {
                    NSArray *varsList = (NSArray *)vars;
                    for (NSDictionary *eachVarDict in varsList) {
                        NSString *eachVar = eachVarDict[@"lf"];
                        [meaningsList addObject:eachVar];
                    }
                }
                [finalMeaningsList addObject:meaningsList];
            }
        }
        
    }
    return finalMeaningsList;
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
