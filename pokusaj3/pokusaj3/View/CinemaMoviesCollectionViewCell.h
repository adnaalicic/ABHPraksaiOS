//
//  CinemaMoviesCollectionViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 09/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetails.h"

@interface CinemaMoviesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
-(void)setupWithMovie:(MovieDetails *)movie;
@end
