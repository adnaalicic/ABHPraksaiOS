//
//  LoginViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) Authentication *authentification;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *u = [[User alloc]init];
    [u setUser];
    // Do any additional setup after loading the view.
    [self.loginButton addTarget:self action:@selector(buttonPressed:)
          forControlEvents:UIControlEventTouchUpInside];

    self.user = u;
    NSLog(@"just need to check");
//    self.password1TextField.secureTextEntry = YES;
    
    UIColor *color = [UIColor lightTextColor];
    self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Your email" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightTextColor].CGColor;
    border.frame = CGRectMake(0, self.emailTextField.frame.size.height - borderWidth, self.emailTextField.frame.size.width, self.emailTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.emailTextField.layer addSublayer:border];
    self.emailTextField.layer.masksToBounds = YES;
    
    
    CALayer *border1 = [CALayer layer];
    CGFloat border1Width = 1;
    border1.borderColor = [UIColor lightTextColor].CGColor;
    border1.frame = CGRectMake(0, self.passwordTextField.frame.size.height - border1Width, self.passwordTextField.frame.size.width, self.passwordTextField.frame.size.height);
    border1.borderWidth = border1Width;
    [self.passwordTextField.layer addSublayer:border1];
    self.passwordTextField.layer.masksToBounds = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)buttonPressed:(id)sender{
        NSLog(@"its ok");
        TMDbClass *tmdbClass = [[TMDbClass alloc] init];
        [tmdbClass getTokenWithSuccess:^(NSArray *array) {
            self.authentification = array[0];
            if([self.authentification.success isEqualToString:@"true"]){
                [tmdbClass getSession:self.authentification.requestToken andUsername:self.emailTextField.text andPassword:self.passwordTextField.text withSuccess:^(NSArray *array) {
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UserLogedIn"];
                    [self performSegueWithIdentifier:@"backToMainScreen" sender:self];
                }];
                
            }
        }];
        
    
   
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([self.authentification.success isEqualToString:@"true"] && [segue.identifier isEqualToString:@"backToMainScreen1"]){
        MovieListViewController *destViewController = segue.destinationViewController;
        destViewController.isLogedIn = YES;
    }
}
@end
