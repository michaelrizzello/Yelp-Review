//
//  APIManager.h
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^APIRequestCompletion)(NSError *error, NSDictionary *jsonData);

@interface APIManager : NSObject

+ (APIManager *)sharedInstance;
- (void) findResturantsWithSearchParams:(NSDictionary *) params andWithCallback: (APIRequestCompletion) callback;
- (void) findResturantsReviews:(NSString *) resturantID andWithCallback: (APIRequestCompletion) callback;
@end
