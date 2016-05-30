//
//  ResturantViewController.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "ResturantViewController.h"
#import "ResturantCell.h"
#import "APIManager.h"
#import "Resturant.h"
#import "LocationManager.h"
#import "GlobalUtilities.h"
#import "ResturantDetail.h"
#import "ViewStackManager.h"
#import "SortingViewController.h"

@interface ResturantViewController()<UICollectionViewDelegate, UICollectionViewDataSource, ResturantSortingControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, strong) NSArray *businesses;

@end

@implementation ResturantViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
 
    self.navigationItem.title = @"Resturants";
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Sort" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 53, 31)];
    [button addTarget:self action:@selector(sortAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];

    self.navigationItem.rightBarButtonItem = barButton;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self requestResturantData:@"Ethiopian"];
    
}

- (void)sortAction
{
    [[ViewStackManager sharedInstance] presentSortingScreen: self];
}

- (void) sortByName
{
    NSArray *sortedArray = [_businesses sortedArrayUsingSelector:
                            @selector(localizedCaseInsensitiveCompare:)];
    _businesses = [[NSArray alloc] initWithArray:sortedArray];
    
    [self.collectionView reloadData];

}

- (void) sortByRating
{
    NSArray *sortedArray = [_businesses sortedArrayUsingComparator:^NSComparisonResult(Resturant* a, Resturant* b) {
        
        float firstDate = a.rating;
        float secondDate = b.rating;
        
        if (firstDate < secondDate)
            return NSOrderedAscending;
        if (firstDate > secondDate)
            return NSOrderedDescending;
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    _businesses = [[NSArray alloc] initWithArray:sortedArray];
    
    [self.collectionView reloadData];

}

- (void) sortByMenuUpdated
{
    NSArray *sortedArray = [_businesses sortedArrayUsingComparator:^NSComparisonResult(Resturant* a, Resturant* b) {
        
        NSUInteger *firstDate = a.menuUpdatedDate;
        NSUInteger *secondDate = b.menuUpdatedDate;
        
        if (firstDate < secondDate)
            return NSOrderedAscending;
        if (firstDate > secondDate)
            return NSOrderedDescending;
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    _businesses = [[NSArray alloc] initWithArray:sortedArray];
    
    [self.collectionView reloadData];

}

- (IBAction)searchAction:(id)sender {

    [self requestResturantData: _searchBar.text];
    
    [_searchBar resignFirstResponder];
}

- (void) requestResturantData: (NSString *) searchText
{
    
    [[ViewStackManager sharedInstance] presentLoadingScreen];
    
    NSString *location = [NSString stringWithFormat:@"%@,%@", [[LocationManager sharedInstance] userCity], [[LocationManager sharedInstance] userCountry]];
    
    NSDictionary *params = @{
                             @"term" : searchText,
                             @"location" : location
                             };
    
    __weak typeof(self) weakSelf = self;
    [[APIManager sharedInstance] findResturantsWithSearchParams:params andWithCallback:^(NSError *error, NSDictionary *jsonData) {
        if ([jsonData objectForKey:@"businesses"])
        {
            NSArray *tempBusinesses = [jsonData objectForKey:@"businesses"];
            
            NSMutableArray *tempBusinessArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < tempBusinesses.count; i++)
            {
                Resturant *res = [[Resturant alloc] initWithJson:tempBusinesses[i]];
                
                [tempBusinessArray addObject:res];
            }
            
            _businesses = [[NSArray alloc] initWithArray:tempBusinessArray];
            
            [[ViewStackManager sharedInstance] dismissLoadingScreen];

            typeof(self) strongSelf = weakSelf;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [strongSelf.collectionView reloadData];
                
            });
        }
        
    }];
    
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * PlainCellIdentifier = @"ResturantCell";
    
    ResturantCell *plainCell = (ResturantCell *)[collectionView dequeueReusableCellWithReuseIdentifier:PlainCellIdentifier forIndexPath:indexPath];
    
    if ( plainCell == nil)
    {
        plainCell = [[ResturantCell alloc] init];
    }
    
    Resturant *res = [_businesses objectAtIndex:[indexPath row]];
    
    plainCell.resturantNameLabel.text = res.resturantName;
    [plainCell.resturantNameLabel sizeThatFits:plainCell.frame.size];
    
    [GlobalUtilities downloadImageFromURL:res.imageURL withCompletion:^(UIImage * downloadedImage) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            plainCell.resturantImage.image = downloadedImage;
        });
        
    }];
    
    return ( plainCell );
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResturantDetail"])
    {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        Resturant *res = [_businesses objectAtIndex:indexPath.row];
        ResturantDetail *destViewController = segue.destinationViewController;
        destViewController.resturant = res;
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ResturantDetail" sender:self];
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_businesses count] > 9)
    {
        return 10;
    }
    else {
        return [_businesses count];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float width = screenRect.size.width/2 - 1;
    float height = screenRect.size.height / 3;
    
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}


@end
