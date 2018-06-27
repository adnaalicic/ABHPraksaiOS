//
//  LoginViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if([self.emailTextField.text isEqualToString:self.user.userEmail] && [self.passwordTextField.text isEqualToString:self.user.userPassword]){
        NSLog(@"its ok");
        TMDbClass *tmdbClass = [[TMDbClass alloc] init];
        [tmdbClass getTokenWithSuccess:^(NSArray *array) {
            self.authentification = array[0];
            [self performSegueWithIdentifier:@"backToMainScreen" sender:self];
            NSLog(@"hello");
            
        }];
        
    }
    else {
        NSLog(@"its not ok");
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([self.authentification.success isEqualToString:@"true"] && [segue.identifier isEqualToString:@"backToMainScreen1"]){
        MovieListViewController *destViewController = segue.destinationViewController;
        destViewController.isLogedIn = YES;
    }
}
@end
