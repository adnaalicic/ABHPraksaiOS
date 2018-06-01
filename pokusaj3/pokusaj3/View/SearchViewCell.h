//
//  SearchViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 30/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface SearchViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearOfReleaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteAverageLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailsButton;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

-(void) setupWithMovie: (Movie *) movie;
@end
