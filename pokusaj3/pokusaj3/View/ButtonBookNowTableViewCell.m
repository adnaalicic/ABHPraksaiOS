//
//  ButtonBookNowTableViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 13/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "ButtonBookNowTableViewCell.h"

@implementation ButtonBookNowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUpDelegate:(id<ButtonBookNowTableViewCellDelegate>)delegate{
    self.delegate = delegate;
}
- (IBAction)buttonClick:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickOnButton)]){
        [self.delegate performSelector:@selector(clickOnButton) withObject:nil];
        
    }
    NSLog(@"tapped");
}

@end
