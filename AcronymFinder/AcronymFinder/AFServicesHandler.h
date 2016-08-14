//
//  AFServicesHandler.h
//  AcronymFinder
//
//  Created by Rohit Marumamula on 8/13/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);

@interface AFServicesHandler : NSObject

-(instancetype)initWithContentType:(NSSet *)set;
-(void)performServiceCallWithURL:(NSString *)url andParameters:(NSDictionary *)params onSuccess:(successBlock)success onFailure:(failureBlock)failure;

@end
