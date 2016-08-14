//
//  AFParser.m
//  AcronymFinder
//
//  Created by Karthik Suresh on 8/13/16.
//  Copyright © 2016 Rohit. All rights reserved.
//

#import "AFParser.h"

@implementation AFParser

+(NSArray *) parseResponse:(NSArray *)response {
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

@end
