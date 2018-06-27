//
//  VideoMovieDetailCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 04/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetails.h"
#import "Genre.h"

@protocol VideoMovieDetailCellDelegate <NSObject>
-(void)openMovieTrailer;
@end

@interface VideoMovieDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIButton *trailerButton;
@property (weak, nonatomic) id<VideoMovieDetailCellDelegate> delegate;
-(void) setupWithMovieDetails:(MovieDetails *)movieDetails andDelegate:(id<VideoMovieDetailCellDelegate>)delegate;
@end
