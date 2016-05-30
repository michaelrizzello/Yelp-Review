//
//  Review.h
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject
@property (nonatomic, strong) NSString *reviewExcerpt;
@property (nonatomic, strong) NSString *reviewersName;
@property (nonatomic) NSUInteger *rating;
@property (nonatomic) NSUInteger *time;

- (instancetype)initWithJson: (NSDictionary *) jsonObject;

@end
