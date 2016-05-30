//
//  ViewStackManager.h
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ResturantViewController.h"

@interface ViewStackManager : NSObject

+ (ViewStackManager *)sharedInstance;

- (void)setMainWindow:(UIWindow*)window;
- (void)presentLoadingScreen;
- (void)dismissLoadingScreen;

- (void)presentSortingScreen:(ResturantViewController *)viewController;
- (void)dismissSortingScreen;
@end
