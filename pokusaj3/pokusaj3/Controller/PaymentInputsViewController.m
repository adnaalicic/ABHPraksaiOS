//
//  PaymentInputsViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 10/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "PaymentInputsViewController.h"

@interface PaymentInputsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mastercardButton;
@property (weak, nonatomic) IBOutlet UIButton *visaButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *expirationTextField;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation PaymentInputsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.backgroundColor = [UIColor clearColor];
    self.cardNumberTextField.backgroundColor = [UIColor clearColor];
    self.expirationTextField.backgroundColor = [UIColor clearColor];
    self.securityCodeTextField.backgroundColor = [UIColor clearColor];
    
    UIColor *color = [UIColor lightTextColor];
    self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.cardNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Card Number" attributes:@{NSForegroundColorAttributeName: color}];
    self.expirationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Expiration" attributes:@{NSForegroundColorAttributeName: color}];
    self.securityCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Security Code" attributes:@{NSForegroundColorAttributeName: color}];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightTextColor].CGColor;
    border.frame = CGRectMake(0, self.nameTextField.frame.size.height - borderWidth, self.nameTextField.frame.size.width, self.nameTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.nameTextField.layer addSublayer:border];
    self.nameTextField.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat border1Width = 1;
    border1.borderColor = [UIColor lightTextColor].CGColor;
    border1.frame = CGRectMake(0, self.cardNumberTextField.frame.size.height - border1Width, self.cardNumberTextField.frame.size.width, self.cardNumberTextField.frame.size.height);
    border1.borderWidth = border1Width;
    [self.cardNumberTextField.layer addSublayer:border1];
    self.cardNumberTextField.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    CGFloat border2Width = 1;
    border2.borderColor = [UIColor lightTextColor].CGColor;
    border2.frame = CGRectMake(0, self.expirationTextField.frame.size.height - border2Width, self.expirationTextField.frame.size.width, self.expirationTextField.frame.size.height);
    border2.borderWidth = border2Width;
    [self.expirationTextField.layer addSublayer:border2];
    self.expirationTextField.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    CGFloat border3Width = 1;
    border3.borderColor = [UIColor lightTextColor].CGColor;
    border3.frame = CGRectMake(0, self.securityCodeTextField.frame.size.height - border3Width, self.securityCodeTextField.frame.size.width, self.securityCodeTextField.frame.size.height);
    border3.borderWidth = border3Width;
    [self.securityCodeTextField.layer addSublayer:border3];
    self.securityCodeTextField.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButton:(id)sender {
    [self performSegueWithIdentifier:@"successfulPayment" sender:self];
}
- (IBAction)visaChecked:(id)sender {
    self.visaButton.backgroundColor = [UIColor blackColor];
    self.visaButton.titleLabel.textColor = [UIColor yellowColor];
    
    
    self.mastercardButton.backgroundColor = [UIColor darkGrayColor];
    self.mastercardButton.titleLabel.textColor = [UIColor whiteColor];
}
- (IBAction)mastercardChecked:(id)sender {
    self.visaButton.backgroundColor = [UIColor darkGrayColor];
    self.visaButton.titleLabel.textColor = [UIColor whiteColor];
    
    self.mastercardButton.backgroundColor = [UIColor blackColor];
    self.mastercardButton.titleLabel.textColor = [UIColor yellowColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
