//
//  MovieDetailTableViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 04/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieDetails.h"
#import "TMDbClass.h"
#import "VideoMovieDetailCell.h"
#import "BasicMovieDetailCell.h"
#import "Credits.h"
#import "Actor.h"
#import "CrewMember.h"
#import "Images.h"
#import "Image.h"
#import "CollectionTableViewCell.h"
#import "ActorCollectionViewCell.h"
#import "PosterInImageGalleryCollectionViewCell.h"
#import "Reviews.h"
#import "Review.h"
#import "ActorDetailsTableViewController.h"
#import "OneReviewTableViewCell.h"
#import "GalleryCollectionViewController.h"
#import "VideoViewController.h"
@interface MovieDetailTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, VideoMovieDetailCellDelegate>
@property (nonatomic, strong) NSString *movieId;
@property (nonatomic, strong) Movie *movie;
@end
