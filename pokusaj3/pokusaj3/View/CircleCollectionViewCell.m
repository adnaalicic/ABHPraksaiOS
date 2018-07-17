//
//  CircleCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 10/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CircleCollectionViewCell.h"

@implementation CircleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.isSelected = NO;
    //self.backgroundColor =[UIColor whiteColor];

}
- (void)setCircleWithColor:(UIColor *)color{
    if(self.view.layer.cornerRadius < self.view.frame.size.height/2 -2){
    CGRect frame = self.view.frame;
    frame.size.height = self.view.frame.size.height - 40;
    frame.size.width = self.view.frame.size.width - 40;
    self.view.frame = frame;
    
    //UIView *circleView = [[UIView alloc] initWithFrame:frame];
    self.view.layer.cornerRadius = frame.size.height/2;  // half the width/height
    }
        self.view.backgroundColor = color;
    //self.view = circleView;

    
}

-(void)setSelectOrDeselect{
    if(self.isSelected == NO){
        self.isSelected = YES;
        self.view.backgroundColor = [UIColor yellowColor];
    }
    else {
        self.isSelected = NO;
        self.view.backgroundColor = [UIColor whiteColor];
    }
}
@end
