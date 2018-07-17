//
//  ButtonTableViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 29/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "ButtonTableViewCell.h"

@implementation ButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setImage:(NSString *)image andTitle:(NSString *)buttonTitle andDelegate:(id<ButtonTableViewCellDelegate>)delegate{
    self.delegate = delegate;
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
    UIImage * buttonImage = [UIImage imageNamed:image];
    [self.button setImage:buttonImage forState:UIControlStateNormal];

}
- (IBAction)logut:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(logout)]){
        [[NSUserDefaults standardUserDefaults] setValue:self.button.titleLabel.text forKey:@"buttonPressed"];
        [self.delegate performSelector:@selector(logout) withObject:nil];
        

    }
    
}

/*-(IBAction)login:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(login)]){
        [self.delegate performSelector:@selector(login) withObject:nil];
    }
}
-(IBAction)settings:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(settings)]){
        [self.delegate performSelector:@selector(settings) withObject:nil];
    }
}
-(IBAction)cinema:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(cinema)]){
        [self.delegate performSelector:@selector(cinema) withObject:nil];
    }
}*/
@end
