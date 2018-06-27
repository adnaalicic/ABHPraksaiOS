//
//  ActorsMovieCollectionViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 13/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetails.h"
#import "Actor.h"

@interface ActorsMovieCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *characterNameLabel;
-(void) setupWithMovie:(MovieDetails *)movie;
-(void) setupWithCharacter: (NSString *)charact;
@end
