//
//  CustomCellCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 20/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CustomCellCollectionViewCell.h"

@implementation CustomCellCollectionViewCell

@synthesize titleLabel;
@synthesize posterImageView;


-(void)setupWithMovie:(Movie *)movie{
    self.titleLabel.text = movie.title;
    self.posterImageView.image = [UIImage imageNamed:@"Bitmap"];
    NSLog(@"pozvalo se");
    
    /*
     NSString *pictureName = [self.pictures objectAtIndex:indexPath.row];
     cell.posterImage.image = [UIImage imageNamed:pictureName];
     [cell.posterImage sizeToFit];
     //cell.posterImage.frame = cell.posterImage.bounds;
     
     CAGradientLayer *gradientMask = [CAGradientLayer layer];
     gradientMask.frame = cell.frame;
     gradientMask.locations = @[@0.5, @1];
     
     gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
     (id)[UIColor whiteColor].CGColor];
     
     //cell.posterImage.layer.mask = gradientMask;
     
     [cell.posterImage.layer insertSublayer:gradientMask atIndex:1];
     */
}

@end
