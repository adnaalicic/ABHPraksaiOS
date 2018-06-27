//
//  LeftSideViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "LeftSideViewController.h"

@interface LeftSideViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

@end

@implementation LeftSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.buttonLogin addTarget:self action:@selector(buttonPressed:)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed:(UIButton *)sender{
    NSLog(@"pressed");
    [self performSegueWithIdentifier:@"showingLogin" sender:self];
}

@end
