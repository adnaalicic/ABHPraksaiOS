//
//  ButtonTableViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 29/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonTableViewCellDelegate <NSObject>
-(void)logout;
@end

@interface ButtonTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, weak) id<ButtonTableViewCellDelegate> delegate;
-(void)setImage:(NSString *)image andTitle:(NSString *)buttonTitle andDelegate:(id<ButtonTableViewCellDelegate>)delegate;
@end
