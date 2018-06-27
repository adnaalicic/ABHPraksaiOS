//
//  OneReviewTableViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 12/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "OneReviewTableViewCell.h"

@implementation OneReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupWithReview:(Review *)review{
    self.authorLabel.text = review.author;
    self.contentLabel.text = review.content;
    
    self.contentLabel.numberOfLines = 3;
}

@end
