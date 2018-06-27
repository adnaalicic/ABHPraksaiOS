//
//  ActorsMovieCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 13/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "ActorsMovieCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation ActorsMovieCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    
    self.characterNameLabel.numberOfLines = 0;
    [self.characterNameLabel sizeToFit];
    // Initialization code
}
-(void) setupWithMovie: (MovieDetails *)movie{
    self.titleLabel.text = movie.title;
    
    [self.posterImageView sd_setImageWithURL:movie.fullPosterPath placeholderImage:nil];
}
-(void) setupWithCharacter: (NSString *)charact{
    self.characterNameLabel.text = charact;
    
}
@end
