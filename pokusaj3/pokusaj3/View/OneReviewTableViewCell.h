//
//  OneReviewTableViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 12/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"

@interface OneReviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

-(void)setupWithReview:(Review *)review;
@end
