//
//  Resturant.h
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resturant : NSObject

@property (nonatomic, strong) NSString *resturantID;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *resturantName;
@property (nonatomic, strong) NSString *ratingImage;
@property (nonatomic) float rating;
@property (nonatomic) NSUInteger *menuUpdatedDate;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSArray *reviews;

- (id) initWithJson: (NSDictionary *) jsonObject;

@end
