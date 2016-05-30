//
//  Resturant.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "Resturant.h"

@implementation Resturant

- (id) initWithJson: (NSDictionary *) jsonObject
{
    self = [super init];
    if (self) {
        
        self.resturantID = [jsonObject objectForKey:@"id"];
        self.imageURL = [jsonObject objectForKey:@"image_url"];
        self.resturantName = [jsonObject objectForKey:@"name"];
        self.ratingImage = [jsonObject objectForKey:@"rating_img_url_large"];
        self.phoneNumber = [jsonObject objectForKey:@"display_phone"];
        self.rating = [[jsonObject objectForKey:@"rating"] floatValue];
        self.menuUpdatedDate = (NSUInteger *) [[jsonObject objectForKey:@"menu_date_updated"] integerValue];
        
    }
    return self;
}
@end
