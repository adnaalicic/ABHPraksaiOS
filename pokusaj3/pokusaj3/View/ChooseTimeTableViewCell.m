//
//  ChooseTimeTableViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 10/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "ChooseTimeTableViewCell.h"

@implementation ChooseTimeTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.titleView addGestureRecognizer:singleFingerTap];
    //self.isSignedIn = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedIn"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void) setUpWithArray:(NSArray *)array isExtended:(BOOL)extended andDelegate:(id<ChooseTimeTableViewCellDelegate>)delegate{
    self.delegate = delegate;
    self.arrayOfItems = array;
    [self.pickerView reloadAllComponents];
    
}
- (void)setTitle:(NSString *)titleOfLabel{
    if(titleOfLabel.length != 0){
        self.titleLabel.text = titleOfLabel;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrayOfItems.count;
}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return self.arrayOfItems[row];
//}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = self.arrayOfItems[row];
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%@",self.arrayOfItems[row]);
    self.titleLabel.text = self.arrayOfItems[row];
    [[NSUserDefaults standardUserDefaults] setValue:self.arrayOfItems[row] forKey:@"selectedDate"];

}
#pragma mark click on view
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickOnView)]){
        [self.delegate performSelector:@selector(clickOnView) withObject:nil];
        
    }
    NSLog(@"tapped");
    
}

@end
