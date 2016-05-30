//
//  APIManager.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "APIManager.h"
#import "NSURLRequest+OAuth.h"

static NSString * const kBaseEndpoint = @"api.yelp.com";
static NSString * const kSearchEndpoint = @"/v2/search/";
static NSString * const kBusinessEndpoint = @"/v2/business/";
static NSString * const kSearchLimit = @"3";

@implementation APIManager

+ (APIManager *)sharedInstance {
    
    static APIManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

+ (NSString *)apiURLHost {
    return @"api.yelp.com";
}

- (void) findResturantsWithSearchParams:(NSDictionary *) params andWithCallback: (APIRequestCompletion) callback
{
        
    NSURLRequest *request = [NSURLRequest requestWithHost:kBaseEndpoint path: kSearchEndpoint params:params];
    NSURLSession *session = [NSURLSession sharedSession];

    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            callback(nil, searchResponseJSON);
        }
        else{
            callback(error, nil); // No business was found
        }
    }] resume];
    
}

- (void) findResturantsReviews:(NSString *) resturantID andWithCallback: (APIRequestCompletion) callback
{
    
    NSString *path = [NSString stringWithFormat:@"%@%@", kBusinessEndpoint, resturantID];
    NSURLRequest *request = [NSURLRequest requestWithHost:kBaseEndpoint path:path];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            callback(nil, searchResponseJSON);
        }
        else{
            callback(error, nil); // No business was found
        }
    }] resume];
    
}

@end
