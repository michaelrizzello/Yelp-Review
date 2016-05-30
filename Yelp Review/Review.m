//
//  Review.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "Review.h"

@implementation Review

- (instancetype)initWithJson: (NSDictionary *) jsonObject
{
    self = [super init];
    if (self) {
        
        NSDictionary *userObject = [jsonObject objectForKey:@"user"];
        _reviewersName = [userObject objectForKey:@"name"];
        
        _reviewExcerpt = [jsonObject objectForKey:@"excerpt"];
        _rating = (NSUInteger *) [[jsonObject objectForKey:@"rating"] integerValue];
        _rating = (NSUInteger *) [[jsonObject objectForKey:@"time_created"] integerValue];

    }
    return self;
}
@end
