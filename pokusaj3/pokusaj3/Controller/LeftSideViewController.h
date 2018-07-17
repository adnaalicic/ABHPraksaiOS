//
//  LeftSideViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonTableViewCell.h"
#import "CinemaListOfMoviesViewController.h"

@protocol LeftSideViewControllerDelegate <NSObject>
-(void)cinemaClicked;
@end

@interface LeftSideViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ButtonTableViewCellDelegate>
@property BOOL isSignedIn;
@property (weak, nonatomic) id<LeftSideViewControllerDelegate>delegate;
-(void)setUpDelegate:(id<LeftSideViewControllerDelegate>)delegate;
@end
