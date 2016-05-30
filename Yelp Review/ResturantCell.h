//
//  ResturantCell.h
//  Yelp Review
//
//  Created by Michael Rizzello on 2016-05-26.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResturantCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *resturantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *resturantImage;

@end
