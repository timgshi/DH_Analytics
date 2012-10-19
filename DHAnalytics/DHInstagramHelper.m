//
//  DHInstagramHelper.m
//  DHAnalytics
//
//  Created by Tim Shi on 10/19/12.
//  Copyright (c) 2012 Tim Shi. All rights reserved.
//

#import "DHInstagramHelper.h"

static NSString *const kInstagramBaseUrl = @"https://api.instagram.com/v1/";

@implementation DHInstagramHelper

+ (NSDictionary *)requestWithMethod:(NSString *)method andParameters:(NSDictionary *)paramDict {
    NSString *requestString = [kInstagramBaseUrl stringByAppendingString:method];
    NSString *authToken = [[PFUser currentUser] objectForKey:@"instagram_token"];
    requestString = [requestString stringByAppendingFormat:@"?access_token=%@", authToken];
    NSURL *requestURL = [NSURL URLWithString:requestString];
    NSData *data = [NSData dataWithContentsOfURL:requestURL];
    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if ([jsonData isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)jsonData;
    }
    return nil;
}

@end
