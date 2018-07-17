//
//  CinemaListOfMoviesViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 09/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaMoviesCollectionViewCell.h"
#import "MovieDetails.h"
@import Firebase;
#import "LGSideMenuController/LGSideMenuController.h"
#import "LGSideMenuController/UIViewController+LGSideMenuController.h"
#import "LeftSideViewController.h"

@interface CinemaListOfMoviesViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>

@end
