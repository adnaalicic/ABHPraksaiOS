//
//  MovieDetailTableViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 04/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "MovieDetailTableViewController.h"

@interface MovieDetailTableViewController ()
@property (nonatomic) int numberOfCells;
@property (nonatomic, strong) MovieDetails *movieDetails;
@property (nonatomic, strong) Credits *credits;
@property (nonatomic, strong) Images *images;
@property (nonatomic, strong) Reviews *reviews;
@property (nonatomic, strong) IBOutlet UIButton *button;
@end

@implementation MovieDetailTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.numberOfCells =5;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *cellNibVideo = [UINib nibWithNibName:@"VideoMovieDetailCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibVideo forCellReuseIdentifier:@"VideoMovieDetailCell"];
    
   
    UINib *cellNibBasic = [UINib nibWithNibName:@"BasicMovieDetailCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibBasic forCellReuseIdentifier:@"BasicMovieDetailCell"];
    
    
    UINib *cellNibGallery = [UINib nibWithNibName:@"CollectionTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibGallery forCellReuseIdentifier:@"CollectionTableViewCell"];
    
    UINib *cellNibReviews = [UINib nibWithNibName:@"ReviewsTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibReviews forCellReuseIdentifier:@"ReviewsTableViewCell"];
    
    UINib *cellNibReview = [UINib nibWithNibName:@"OneReviewTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibReview forCellReuseIdentifier:@"OneReviewTableViewCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
   
    TMDbClass *tmbdClass = [[TMDbClass alloc] init];
    
    [tmbdClass getMovieDetails:self.movieId withSuccess:^(NSArray *array) {
        self.movieDetails = array[0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];

    }];
    [tmbdClass getMovieCredits:self.movieId withSuccess:^(NSArray *array) {
        self.credits = array[0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [tmbdClass getMovieImages:self.movieId withSuccess:^(NSArray *array) {
        self.images = array[0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [tmbdClass getMovieReviews:self.movieId withSuccess:^(NSArray *array) {
        self.reviews = array[0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"Movies";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
      return self.numberOfCells;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 4){
        return self.reviews.reviewsList.count;
    }
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
            cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell" forIndexPath:indexPath];
            [(CollectionTableViewCell *)cell setupWithDataSourceDelegate:self position:2];
            [[(CollectionTableViewCell *)cell collectionView] reloadData];
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell" forIndexPath:indexPath];
            [(CollectionTableViewCell *)cell setupWithDataSourceDelegate:self position:3];
            [[(CollectionTableViewCell *)cell collectionView] reloadData];
            break;
        case 4:
            cell = [tableView dequeueReusableCellWithIdentifier:@"OneReviewTableViewCell" forIndexPath:indexPath];
            [(OneReviewTableViewCell *)cell setupWithReview:[self.reviews.reviewsList objectAtIndex:indexPath.row]];
            

            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = UITableViewAutomaticDimension;
    if(indexPath.section == 2){
        return 105;
    }
    else if(indexPath.section == 3){
        return 200;
    }
    else if(indexPath.section == 4){
        return 135;
    }
    return rowHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //U SLUCAJU 2 3 I 4 VRATI ovo a suptrotno vrati nil
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, tableView.frame.size.width, 18)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button.center = CGPointMake(tableView.frame.size.width - 70, 2.5);
    [button setTitle:@"See all" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    [label setTextColor:[UIColor whiteColor]];
    [button sizeToFit];
    self.button = button;
    [self.button addTarget:self action:@selector(buttonPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    NSString *string =@"";
    
    switch (section) {
        case 2:
            string =@"Image gallery";
            [view addSubview:button];
            

            break;
        case 3:
            string =@"Cast";
            break;
        case 4:
            
            string = self.reviews.reviewsList.count ? @"Reviews" : @"";
            break;
        default:
            break;
    }
   
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor blackColor]]; //your background color...
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // u slucaju 2,3 4 vrati velicinu, a suprotnom vrati 0.0001
    CGFloat fl=35;
    switch (section) {
        case 0:
            fl = 0.00001;
            break;
        case 1:
            fl = 0.0001;
        default:
            break;
    }
    
    return fl;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
#pragma mark Collection View 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if(collectionView.tag == 2 && [self.images.backdropList count]){

        return [self.images.backdropList count];
    }
    else if(collectionView.tag == 3 && self.credits.actorsList.count) {
        return self.credits.actorsList.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if(collectionView.tag == 2){

        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PosterInImageGalleryCollectionViewCell" forIndexPath:indexPath];
        [(PosterInImageGalleryCollectionViewCell *)cell setupWithImage:[self.images.backdropList objectAtIndex:indexPath.row]];
        
    }
    else if(collectionView.tag == 3){
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActorCollectionViewCell" forIndexPath:indexPath];
        [(ActorCollectionViewCell *)cell setupWithActor:[self.credits.actorsList objectAtIndex:indexPath.row]];
        
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 2) {
        return CGSizeMake(93, 97);
    }
    return CGSizeMake(80, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView.tag == 3){
    [self performSegueWithIdentifier:@"ShowingActorDetails" sender:self];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowingActorDetails"]){
    
        NSIndexPath *indexPath = [[[(CollectionTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]] collectionView] indexPathsForSelectedItems] firstObject];
        
        ActorDetailsTableViewController *destViewController = segue.destinationViewController;
        Actor *a= [self.credits.actorsList objectAtIndex:indexPath.row];
        
        destViewController.actorId = a.actorId;
    }
    else if([segue.identifier isEqualToString:@"ShowingCollectionOfImages"]){
        GalleryCollectionViewController *destViewController = segue.destinationViewController;
        destViewController.images = self.images.backdropList;
        destViewController.movieTitle = self.movieDetails.title;
        destViewController.title = @"Movies";
    }
    else if([segue.identifier isEqualToString:@"showingTrailer"]){
        VideoViewController *destViewController = segue.destinationViewController;
        destViewController.movie = self.movieDetails;
        destViewController.title = @"Movies";
    }
}
#pragma mark VideoMovieDetailCell Delegate method
-(void)openMovieTrailer{
    [self performSegueWithIdentifier:@"showingTrailer" sender:self];
    NSLog(@"open movie trailer");
}
#pragma mark Button

- (IBAction)buttonPressed:(UIButton *)button {
    //ShowingCollectionOfImages
    [self performSegueWithIdentifier:@"ShowingCollectionOfImages" sender:self];
}
@end
