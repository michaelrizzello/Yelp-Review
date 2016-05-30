//
//  NSURLRequest+OAuth.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "NSURLRequest+OAuth.h"

#import <TDOAuth/TDOAuth.h>

static NSString * const kConsumerKey       = @"TcxUjZKlyKN-1irj5unB5w";
static NSString * const kConsumerSecret    = @"1Pxg3H9ezEli5OeMVVBO2GZ7wA4";
static NSString * const kToken             = @"A28tK3Ui2KpQyYdcALyEUaER7tzzC1H7";
static NSString * const kTokenSecret       = @"s_kmM5ofQH41f9l9SY67_VCd2Kc";

@implementation NSURLRequest (OAuth)

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path {
        
    return [self requestWithHost:host path:path params:nil];
}

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params {
    if ([kConsumerKey length] == 0 || [kConsumerSecret length] == 0 || [kToken length] == 0 || [kTokenSecret length] == 0) {
        NSLog(@"Missing authentication keys");
    }
    
    return [TDOAuth URLRequestForPath:path
                        GETParameters:params
                               scheme:@"https"
                                 host:host
                          consumerKey:kConsumerKey
                       consumerSecret:kConsumerSecret
                          accessToken:kToken
                          tokenSecret:kTokenSecret];
}

@end
