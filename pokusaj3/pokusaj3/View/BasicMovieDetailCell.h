//
//  BasicMovieDetailCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 04/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetails.h"
#import "Credits.h"
#import "Actor.h"
#import "CrewMember.h"

@interface BasicMovieDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionLabel1;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UILabel *writersLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteAverageLabel;

-(void) setupWithMovieDetails:(MovieDetails *)movieDetails;
-(void) setupWIthCredits:(Credits *)credits;
@end
