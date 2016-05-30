//
//  SortingViewController.h
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResturantSortingControllerDelegate <NSObject>
- (void)sortByName;
- (void)sortByMenuUpdated;
- (void)sortByRating;
@end

@interface SortingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id<ResturantSortingControllerDelegate> delegate;

@end