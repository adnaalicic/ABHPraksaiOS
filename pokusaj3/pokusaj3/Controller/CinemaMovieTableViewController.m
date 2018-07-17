//
//  CinemaMovieTableViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 29/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CinemaMovieTableViewController.h"
#import "TMDbClass.h"
#import "Credits.h"
#import "Actor.h"
#import "CrewMember.h"
@import Firebase;

@interface CinemaMovieTableViewController ()
@property (nonatomic, readwrite) FIRFirestore *db;
@property (nonatomic, strong) MovieDetails *movieDetails;
@property (nonatomic, strong) Credits *credits;
@property (nonatomic, strong) NSArray *timeArray;
@property int heightForTimeCell;
@property BOOL isExtended;

@end

@implementation CinemaMovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"selectedDate"];

    self.timeArray =[[NSArray alloc]init];
    self.timeArray = @[@"13/07/2018",@"14/07/2018",@"15/07/2018",@"16/07/2018",];
    self.heightForTimeCell = 59;
    self.isExtended = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.separatorColor =[UIColor redColor];
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *cellNibVideo = [UINib nibWithNibName:@"VideoMovieDetailCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibVideo forCellReuseIdentifier:@"VideoMovieDetailCell"];
    
    
    UINib *cellNibBasic = [UINib nibWithNibName:@"BasicMovieDetailCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibBasic forCellReuseIdentifier:@"BasicMovieDetailCell"];
    
    UINib *cellNibTime = [UINib nibWithNibName:@"ChooseTimeTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibTime forCellReuseIdentifier:@"ChooseTimeTableViewCell"];
    
    UINib *cellNibBooNow = [UINib nibWithNibName:@"ButtonBookNowTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibBooNow forCellReuseIdentifier:@"ButtonBookNowTableViewCell"];
    
    TMDbClass *tmdbClass = [[TMDbClass alloc]init];
    [tmdbClass getMovieDetails:self.movieId withSuccess:^(NSArray *array) {
        self.movieDetails = array[0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    [tmdbClass getMovieCredits:self.movieId withSuccess:^(NSArray *array) {
        self.credits = array[0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
       // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"VideoMovieDetailCell" forIndexPath:indexPath];
            [(VideoMovieDetailCell *)cell setupWithMovieDetails:self.movieDetails andDelegate:self];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"BasicMovieDetailCell" forIndexPath:indexPath];
            [(BasicMovieDetailCell *)cell setupWithMovieDetails:self.movieDetails];
            [(BasicMovieDetailCell *)cell setupWIthCredits:self.credits];
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseTimeTableViewCell" forIndexPath:indexPath];
            [(ChooseTimeTableViewCell *)cell setUpWithArray:self.timeArray isExtended:self.isExtended andDelegate:self];
            NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedDate"];
            [(ChooseTimeTableViewCell *)cell setTitle:str];
            break;
        }
            case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonBookNowTableViewCell" forIndexPath:indexPath];
            [(ButtonBookNowTableViewCell *)cell setUpDelegate:self];
            break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = UITableViewAutomaticDimension;
    switch (indexPath.section) {
        case 2:
            rowHeight = self.heightForTimeCell;
            break;
        case 3:
            rowHeight = 101;
            break;
        default:
            break;
    }
    return rowHeight;
}

#pragma mark VideoMovieDetailsCell Delegate method
-(void)openMovieTrailer{
    
}
#pragma mark ChooseTimeTableCell delegate method
-(void)clickOnView{
    NSLog(@"helloo");
    if(self.isExtended){
        self.heightForTimeCell = 59;
        self.isExtended = NO;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else{
        self.heightForTimeCell = 180;
        self.isExtended = YES;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}

#pragma mark ButtonBookNowTableViewCell delegate
-(void)clickOnButton{
    [self performSegueWithIdentifier:@"showingCinemaHall" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if( [segue.identifier isEqualToString:@"showingCinemaHall"]){
        
        
        
        
        CinemaSeatsViewController *destViewController = segue.destinationViewController;
        
        destViewController.movieId= self.movieDetails.movieId;
        destViewController.movieTitle = self.movieDetails.title;
    }
}
@end
