//
//  CinemaMovieTableViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 29/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoMovieDetailCell.h"
#import "BasicMovieDetailCell.h"
#import "ChooseTimeTableViewCell.h"
#import "ButtonBookNowTableViewCell.h"
#import "CinemaSeatsViewController.h"

@interface CinemaMovieTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,VideoMovieDetailCellDelegate, ChooseTimeTableViewCellDelegate, ButtonBookNowTableViewCellDelegate>
@property (strong) NSString *movieId;
@end
