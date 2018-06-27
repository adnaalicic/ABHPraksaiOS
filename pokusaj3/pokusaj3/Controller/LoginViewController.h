//
//  LoginViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TMDbClass.h"
#import "Authentication.h"
#import "MovieListViewController.h"

@interface LoginViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) User *user;

@end
