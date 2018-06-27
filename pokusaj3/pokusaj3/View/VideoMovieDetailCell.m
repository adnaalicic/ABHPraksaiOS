//
//  VideoMovieDetailCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 04/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "VideoMovieDetailCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation VideoMovieDetailCell
{
    CAGradientLayer *gradientMask;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 677"]];
    
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setupWithMovieDetails:(MovieDetails *)movieDetails andDelegate:(id<VideoMovieDetailCellDelegate>)delegate{
    self.delegate = delegate;
    self.titleLabel.text = movieDetails.title;
    self.dateLabel.text = movieDetails.getDate;
    self.timeLabel.text = movieDetails.movieLength;
    NSString *futureLabel =@"";
    for(int i = 0; i < movieDetails.genresList.count; i++){
        Genre *genre = movieDetails.genresList[i];
        futureLabel =[futureLabel stringByAppendingString:genre.name];
        if(i < movieDetails.genresList.count -1){
            futureLabel =[futureLabel stringByAppendingString:@", "];
        }

    }
    self.genreLabel.text = futureLabel;
   
    [self.posterImageView sd_setImageWithURL:movieDetails.fullPosterPath placeholderImage:nil];
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
- (IBAction)performShowTrailer:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(openMovieTrailer)]){
        [self.delegate performSelector:@selector(openMovieTrailer) withObject:nil];
    }
}
@end
