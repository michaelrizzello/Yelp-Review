//
//  GlobalUtilities.h
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalUtilities : NSObject

+ (void)downloadImageFromURL:(NSString*)url withCompletion:(void (^)(UIImage*))completion;
+ (UIImage*)scaledImage:(UIImage*)sourceImage cacheKey:(NSString*)cacheKey;

@end
