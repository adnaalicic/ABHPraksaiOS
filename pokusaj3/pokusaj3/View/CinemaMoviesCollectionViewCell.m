//
//  CinemaMoviesCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 09/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CinemaMoviesCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CinemaMoviesCollectionViewCell
{
    CAGradientLayer *gradientMask;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setupWithMovie:(MovieDetails *)movie{
    [self.posterImageView sd_setImageWithURL:movie.fullPosterPath placeholderImage:nil];
    self.titleLabel.text = movie.title;
    self.voteLabel.text = movie.voteAverageString;
    self.genreLabel.text = movie.genresList[0];
    [self setGradient];
}
-(void) setGradient {
    if(gradientMask == nil){
        gradientMask = [CAGradientLayer layer];
        CGRect futureFrame = self.bounds;
        futureFrame.size.width =[[UIScreen mainScreen]bounds].size.width;
        gradientMask.frame = futureFrame;
        
        //gradientMask.frame.size.width = [[UIScreen mainScreen]bounds].size.width;
        gradientMask.locations = @[@0.02, @0.8];
        gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
                                (id)[UIColor blackColor].CGColor];
        //self.backgroundColor = [UIColor clearColor];
        [self.posterImageView.layer insertSublayer:gradientMask atIndex:0];
    }
}
@end
