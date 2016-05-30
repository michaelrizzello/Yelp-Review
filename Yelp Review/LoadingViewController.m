//
//  LoadingViewController.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController()
@end

@implementation LoadingViewController

- (instancetype)init {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"LoadingViewController"];
    
    return self;
}

- (void)presentInViewController:(UIViewController*)viewController {
    
    self.view.alpha = 0.0;
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
    self.view.frame = viewController.view.bounds;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 1.0f;
    }];
    
    
    [self.spinner startAnimating];
}

@end
