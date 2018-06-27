//
//  CustomCellCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 20/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CustomCellCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Genre.h"
#import "MovieDetails.h"

@implementation CustomCellCollectionViewCell

{
    CAGradientLayer *gradientMask;
}

-(void)setupWithMovie:(MovieDetails *)movie{
    //setting labels
    printf("%ld", (long)movie.movieId);
    self.titleLabel.text = movie.title;
    self.titleLabel.numberOfLines = 4;
    [self.titleLabel sizeToFit];
    self.releaseDateLabel.text = movie.getDate;
    self.rateLabel.text = movie.voteAverageString;
   
   
    [self.posterImageView sd_setImageWithURL:movie.fullPosterPathForCollection placeholderImage:nil];
    [self setGradient];
    


}
-(void) setupGenre:(NSString *)genre{
    self.genreLabel.text = genre;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
        }
    }
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
