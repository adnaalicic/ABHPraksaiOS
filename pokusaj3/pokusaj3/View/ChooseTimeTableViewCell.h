//
//  ChooseTimeTableViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 10/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseTimeTableViewCellDelegate  <NSObject>
-(void)clickOnView;
@end
@interface ChooseTimeTableViewCell : UITableViewCell<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) id<ChooseTimeTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *arrayOfItems;
-(void) setUpWithArray:(NSArray *)array isExtended:(BOOL)extended andDelegate:(id<ChooseTimeTableViewCellDelegate>)delegate;
-(void) setTitle:(NSString *)titleOfLabel;
@end
