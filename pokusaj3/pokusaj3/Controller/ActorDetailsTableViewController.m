//
//  ActorDetailsTableViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 12/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "ActorDetailsTableViewController.h"

@interface ActorDetailsTableViewController ()

@property (nonatomic, strong) IBOutlet UIButton *button;
@end

@implementation ActorDetailsTableViewController

{
    BOOL isBioExtended;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isBioExtended = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.listOfCharacters = [[NSMutableArray alloc] init];

    self.view.backgroundColor = [UIColor blackColor];
    
    
    [self.button addTarget:self action:@selector(buttonPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    UINib *cellNibBasic = [UINib nibWithNibName:@"ActorDetailsTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibBasic forCellReuseIdentifier:@"ActorDetailsTableViewCell"];
    
    UINib *cellNibGallery = [UINib nibWithNibName:@"CollectionTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNibGallery forCellReuseIdentifier:@"CollectionTableViewCell"];

    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
    TMDbClass *tmbdClass = [[TMDbClass alloc] init];
    [tmbdClass getActor:self.actorId withSuccess:^(NSArray *array) {
        self.actor = array[0];
         [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [tmbdClass getActorsMovies:self.actorId withSuccess:^(NSArray *array) {
        self.movies = array;
        
        if(self.movies.count){
            for(int i = 0; i < self.movies.count; i++){
                MovieDetails *movieDetails = self.movies[i];
                
                [tmbdClass getMovieCredits: movieDetails.movieId withSuccess:^(NSArray *array) {
                    if(array.count){
                        Credits *movieCredits = array[0];
                        
                        if(movieCredits.actorsList.count){
                            for(int j = 0; j < movieCredits.actorsList.count; j++){
                                Actor *actor = movieCredits.actorsList[j];
                                if(actor.actorId == self.actorId){
                                    [self.listOfCharacters addObject:actor.character];
                                    break;
                                }
                            }
                            
                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                            
                        }
                    }
                }];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];

            
        }
        
    }];
    self.title = @"Actor";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"ActorDetailsTableViewCell" forIndexPath:indexPath];
            [(ActorDetailsTableViewCell *)cell setupWithActor:self.actor extended:isBioExtended andDelegate:self];
            
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell" forIndexPath:indexPath];
            [(CollectionTableViewCell *)cell setupWithDataSourceDelegate:self position:1];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
           
            break;
        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = UITableViewAutomaticDimension;
    if(indexPath.section == 0){
        return UITableViewAutomaticDimension;
    }
    else if(indexPath.section == 1){
        return 200;
    }
    return rowHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    label.text = @"Filmography";
    
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    [label setTextColor:[UIColor whiteColor]];

    switch (section) {
        case 1:
            [view addSubview:label];
            break;
            
        default:
            break;
    }
    [view setBackgroundColor:[UIColor blackColor]];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0.00001;
        case 1:
            return 25;
        default:
            break;
    }
    return 0.0001;
}
#pragma mark Collection View
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActorsMovieCollectionViewCell" forIndexPath:indexPath];
    
    if(self.movies.count){
    [(ActorsMovieCollectionViewCell *)cell setupWithMovie:[self.movies objectAtIndex:indexPath.row]];
    }
    if(self.listOfCharacters.count != 0 && self.listOfCharacters.count > indexPath.row){
        [(ActorsMovieCollectionViewCell *)cell setupWithCharacter:[self.listOfCharacters objectAtIndex:indexPath.row]];
    }
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movies.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 210);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showingMovieDetails" sender:self];
}
-(IBAction)buttonPressed:(id)sender{
    NSLog(@"okkk");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [[[(CollectionTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] collectionView] indexPathsForSelectedItems] firstObject];
    MovieDetailTableViewController *destViewController = segue.destinationViewController;
    MovieDetails *movie = [self.movies objectAtIndex:indexPath.row];
    destViewController.movieId = movie.movieId;
}
#pragma mark ActorDetailsTableViewCell Delegate method
-(void)showFullBio{
    isBioExtended = !isBioExtended;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];

    
}
@end
