//
//  AFServicesHandler.m
//  AcronymFinder
//
//  Created by Rohit Marumamula on 8/13/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import "AFServicesHandler.h"
#import <AFNetworking/AFNetworking.h>

@interface AFServicesHandler()

@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end


@implementation AFServicesHandler

-(instancetype)init {
    return [self initWithContentType:[NSSet setWithObject:@"text/plain"]];
}

-(instancetype)initWithContentType:(NSSet *)set {
    self = [super init];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer.acceptableContentTypes = set;
    return self;
}

-(void)performServiceCallWithURL:(NSString *)url andParameters:(NSDictionary *)params onSuccess:(successBlock)success onFailure:(failureBlock)failure {
    
    [self.manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure != nil) {
            failure(error);
        }
    }];
}


@end
