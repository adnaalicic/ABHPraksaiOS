//
//  CustomCellCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 20/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CustomCellCollectionViewCell.h"

@implementation CustomCellCollectionViewCell

{
    CAGradientLayer *gradientMask;
}

-(void)setupWithMovie:(Movie *)movie{
    //setting labels
    self.titleLabel.text = movie.title;
    self.titleLabel.numberOfLines = 4;
    [self.titleLabel sizeToFit];
    self.releaseDateLabel.text = movie.releaseDate;
    self.rateLabel.text = movie.voteAverageString;
    NSData *data = [NSData dataWithContentsOfURL:movie.fullPosterPath];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.posterImageView setImage:[UIImage imageWithData:data]];
    });
    
    [self setGradient];
    


}

-(void) setGradient {
    if(gradientMask == nil){
        gradientMask = [CAGradientLayer layer];
        gradientMask.frame = self.bounds;
        gradientMask.locations = @[@0.02, @0.8];
        gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
                                (id)[UIColor blackColor].CGColor];
        //self.backgroundColor = [UIColor clearColor];
        [self.posterImageView.layer insertSublayer:gradientMask atIndex:0];
    }
}

@end
