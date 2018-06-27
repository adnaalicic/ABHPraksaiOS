//
//  VideoViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "MovieDetails.h"

@interface VideoViewController : UIViewController <YTPlayerViewDelegate>
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;
@property(nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property(nonatomic, strong) MovieDetails *movie;

@end
