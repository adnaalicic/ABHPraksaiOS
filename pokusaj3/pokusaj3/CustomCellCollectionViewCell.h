//
//  CustomCellCollectionViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 20/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface CustomCellCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteAverageLabel;

-(void) setupWithMovie:(Movie *) movie;

@end
