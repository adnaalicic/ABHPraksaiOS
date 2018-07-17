//
//  LeftSideViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "LeftSideViewController.h"
#import "LGSideMenuController.h"

@interface LeftSideViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isSignedIn = nil;
    self.isSignedIn = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedIn"];
    
    UINib *cellNibBasic = [UINib nibWithNibName:@"ButtonTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibBasic forCellReuseIdentifier:@"ButtonTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableView Data Source and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedIn"] isEqual:[NSNumber numberWithInteger:1]]){
        return 3;
    }
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonTableViewCell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedIn"] isEqual:[NSNumber numberWithInteger:1]]){
                [(ButtonTableViewCell *)cell setImage:@"cinema_gray_icon" andTitle:@"Cinema" andDelegate:self];

            }
            else {
                [(ButtonTableViewCell *)cell setImage:@"login_gray_icon" andTitle:@"Login" andDelegate:self];
            }
            break;
        case 1:
            [(ButtonTableViewCell *)cell setImage:@"Group 12 Copy.pgn" andTitle:@"Settings" andDelegate:self];
            break;
        case 2:
            [(ButtonTableViewCell *)cell setImage:@"Redo-48.pgn" andTitle:@"Logout" andDelegate:self];
            
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0;
}

#pragma mark ButtonTableViewCell delegate
-(void)logout{
    NSLog(@"logout");
    NSString *pressedButton = [[NSUserDefaults standardUserDefaults] valueForKey:@"buttonPressed"];
    if([pressedButton isEqualToString:@"Logout"]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Logout"
                                                                       message:@"Are you sure you want to logout?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [[NSUserDefaults standardUserDefaults] setBool:nil forKey:@"UserLogedIn"];
                                                                  self.isSignedIn = NO;
                                                                  [self performSegueWithIdentifier:@"showBack" sender:self];

                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                              }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if([pressedButton isEqualToString:@"Settings"]){
        
    }
    else if([pressedButton isEqualToString:@"Cinema"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CinemaListOfMoviesViewController *cinemaListOfMoviesViewController = [storyboard instantiateViewControllerWithIdentifier:@"CinemaListOfMoviesViewController"];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cinemaListOfMoviesViewController];
        navigationController.navigationBar.barTintColor = [UIColor blackColor];
        ((LGSideMenuController *)self.parentViewController).rootViewController = navigationController;
        [(LGSideMenuController *)self.parentViewController hideLeftViewAnimated];
    }
    else if([pressedButton isEqualToString:@"Login"]){
        [self performSegueWithIdentifier:@"showingLogin" sender:self];

    }
}
- (void)setUpDelegate:(id<LeftSideViewControllerDelegate>)delegate{
    self.delegate = delegate;
}


@end
