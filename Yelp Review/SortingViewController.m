//
//  SortingViewController.m
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import "SortingViewController.h"
#import "Resturant.h"
#import "ViewStackManager.h"

@interface SortingViewController()
@property (weak, nonatomic) IBOutlet UITableView *sortingTableview;
@property (nonatomic, strong) NSArray *sortByArray;
@end

@implementation SortingViewController

- (instancetype)init {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"SortingViewController"];
    
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _sortByArray = [[NSArray alloc] initWithObjects:@"Name", @"Rating", @"Menu Updated Date", nil];
    
    _sortingTableview.delegate = self;
    _sortingTableview.dataSource = self;
    
    [_sortingTableview reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (![[touch view] isEqual:_sortingTableview])
    {
        [[ViewStackManager sharedInstance] dismissSortingScreen];
    }
    
    
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - UITableviewDelegate methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sortByArray.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //SortingCell
    
    static NSString * PlainCellIdentifier = @"SortingCell";
    
    UITableViewCell *plainCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:PlainCellIdentifier forIndexPath:indexPath];
    
    if ( plainCell == nil)
    {
        plainCell = [[UITableViewCell alloc] init];
    }
    
    NSString *res = [_sortByArray objectAtIndex:[indexPath row]];
    
    plainCell.textLabel.text = res;
    
    return ( plainCell );
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) //Name
    {
        if (self.delegate)
        {
            [self.delegate sortByName];
        }
    }
    else if (indexPath.row == 1) //Rating
    {
        if (self.delegate)
        {
            [self.delegate sortByRating];
        }
    }
    else if (indexPath.row == 2)
    {
        if (self.delegate)
        {
            [self.delegate sortByMenuUpdated];
        }
    }
    
    [[ViewStackManager sharedInstance] dismissSortingScreen];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
