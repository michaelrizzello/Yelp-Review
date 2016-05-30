//
//  ViewStackManager.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "ViewStackManager.h"
#import "LoadingViewController.h"
#import "SortingViewController.h"

@interface ViewStackManager()
@property (nonatomic, weak) UIWindow *mainWindow;
@property (nonatomic, strong) LoadingViewController *loadingScreen;
@property (nonatomic, strong) SortingViewController *sortViewController;
@end

@implementation ViewStackManager

+ (ViewStackManager *)sharedInstance {
    
    static ViewStackManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (void)setMainWindow:(UIWindow*)window {
    
    if (!_mainWindow) {
        _mainWindow = window;
    }
}

- (LoadingViewController *)loadingScreen {
    
    if (!_loadingScreen) {
        _loadingScreen = [[LoadingViewController alloc] init];
        _loadingScreen.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    return _loadingScreen;
}

- (SortingViewController *)sortViewController {
    
    if (!_sortViewController) {
        _sortViewController = [[SortingViewController alloc] init];
        _sortViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    return _sortViewController;
}


- (void)presentLoadingScreen {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentSubview:self.loadingScreen];
        [self.loadingScreen.spinner startAnimating];
    });
}

- (void)dismissLoadingScreen {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
            [self dismissSubview:self.loadingScreen];
    });
}

- (void)presentSortingScreen:(ResturantViewController *)viewController {
    
    if (viewController)
    {
        //self.sortViewController.resturantViewController = viewController;
        self.sortViewController.delegate = viewController;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentSubview:self.sortViewController];
    });
}

- (void)dismissSortingScreen {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self dismissSubview:self.sortViewController];
    });
}

- (void)presentSubview:(UIViewController*)viewController {
        
    if (!viewController.view.superview) {
        viewController.view.frame = self.mainWindow.bounds;
        [self.mainWindow.rootViewController.view addSubview:viewController.view];
        [self.mainWindow.rootViewController addChildViewController:viewController];
        viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        viewController.view.alpha = 0.0f;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        viewController.view.alpha = 1.0f;
    }];
}

- (void) dismissSubview:(UIViewController*)viewController {
    if (!viewController) {
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        viewController.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }];
}

@end
