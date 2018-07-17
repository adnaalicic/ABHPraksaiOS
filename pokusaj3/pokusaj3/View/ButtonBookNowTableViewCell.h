//
//  ButtonBookNowTableViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 13/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonBookNowTableViewCellDelegate <NSObject>
-(void)clickOnButton;
@end

@interface ButtonBookNowTableViewCell : UITableViewCell
@property (weak, nonatomic) id<ButtonBookNowTableViewCellDelegate> delegate;
-(void) setUpDelegate:(id<ButtonBookNowTableViewCellDelegate>)delegate;
@end
