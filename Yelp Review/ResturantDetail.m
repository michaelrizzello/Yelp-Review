//
//  ResturantDetail.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "ResturantDetail.h"
#import "GlobalUtilities.h"
#import "APIManager.h"
#import "Review.h"

@interface ResturantDetail()
@property (weak, nonatomic) IBOutlet UIImageView *resturantImage;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation ResturantDetail

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = _resturant.resturantName;
    
    [GlobalUtilities downloadImageFromURL:_resturant.imageURL withCompletion:^(UIImage * downloadedImage) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _resturantImage.image = downloadedImage;
        });
        
    }];
    
    [GlobalUtilities downloadImageFromURL:_resturant.ratingImage withCompletion:^(UIImage * downloadedImage) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _ratingImage.image = downloadedImage;
        });
        
    }];
    
    [self requestFirstReview];
}


- (void) requestFirstReview
{
    [[APIManager sharedInstance] findResturantsReviews:_resturant.resturantID andWithCallback:^(NSError *error, NSDictionary *jsonData) {
        
        if (jsonData.count > 0)
        {
            NSArray *reviewObjects = [jsonData objectForKey:@"reviews"];
            NSLog(@"%@", reviewObjects);
            
            NSMutableArray *tempReviewObjs = [[NSMutableArray alloc] init];
            
            for (NSDictionary *aReviewObj in reviewObjects)
            {
                Review *aReview = [[Review alloc] initWithJson:aReviewObj];
                [tempReviewObjs addObject:aReview];
            }
            
            NSArray *sortedArray = [tempReviewObjs sortedArrayUsingComparator:^NSComparisonResult(Review* a, Review* b) {

                NSUInteger *firstDate = a.time;
                NSUInteger *secondDate = b.time;
                
                if (firstDate < secondDate)
                    return NSOrderedAscending;
                if (firstDate > secondDate)
                    return NSOrderedDescending;
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            Review *latestReview = [sortedArray firstObject];
            
            NSString *review = [NSString stringWithFormat:@"%@ - %@", latestReview.reviewExcerpt, latestReview.reviewersName];
            dispatch_async(dispatch_get_main_queue(), ^{
                _ratingLabel.text = review;
            });


        }
    }];
}


@end
