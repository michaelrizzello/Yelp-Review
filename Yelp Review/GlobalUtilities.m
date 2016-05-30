//
//  GlobalUtilities.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "GlobalUtilities.h"
#import "PINRemoteImageManager.h"
#import "PINCache.h"

@implementation GlobalUtilities

+ (void)downloadImageFromURL:(NSString*)url withCompletion:(void (^)(UIImage*))completion {
    
    NSString *cacheKey = [[PINRemoteImageManager sharedImageManager]cacheKeyForURL:[NSURL URLWithString:url] processorKey:@"scale-retina"];
    
    id checkScale = [[PINCache sharedCache].memoryCache objectForKey:cacheKey];
    if (checkScale && [checkScale isKindOfClass:[UIImage class]]) {
        
        UIImage *sourceImage = (UIImage*)checkScale;
        if (sourceImage.scale != [UIScreen mainScreen].scale) {
            sourceImage = [self scaledImage:sourceImage cacheKey:cacheKey];
        }
        
        completion(sourceImage);
        return;
    }
    
    [[PINRemoteImageManager sharedImageManager] downloadImageWithURL:[NSURL URLWithString:url] options:PINRemoteImageManagerDownloadOptionsNone processorKey:[NSString stringWithFormat:@"scale-retina"] processor:^UIImage *(PINRemoteImageManagerResult *result, NSUInteger *cost) {
        
        return [self scaledImage:result.image cacheKey:nil];
        
    } completion:^(PINRemoteImageManagerResult *result) {
        completion([self scaledImage:result.image cacheKey:cacheKey]);
    }];
}

+ (UIImage*)scaledImage:(UIImage*)sourceImage cacheKey:(NSString*)cacheKey {
    
    CGFloat screenScale = [UIScreen mainScreen].scale;
    if (sourceImage && sourceImage.scale != screenScale) {
        sourceImage = [UIImage imageWithCGImage:sourceImage.CGImage scale:screenScale orientation:sourceImage.imageOrientation];
        
        if (cacheKey) {
            [[PINCache sharedCache].memoryCache setObject:sourceImage forKey:cacheKey];
        }
    }
    
    return sourceImage;
}

@end
