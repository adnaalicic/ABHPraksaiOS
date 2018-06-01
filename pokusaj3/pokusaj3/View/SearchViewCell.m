//
//  SearchViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 30/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "SearchViewCell.h"

@implementation SearchViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupWithMovie:(Movie *)movie {
    
    self.titleLabel.text = movie.title;
    self.voteAverageLabel.text = movie.stringFormatOfVoteAverage;
    self.yearOfReleaseLabel.text = movie.releaseDate;
    NSData *data = [NSData dataWithContentsOfURL:movie.fullPosterPath];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.posterImageView setImage:[UIImage imageWithData:data]];
    });
}

@end
