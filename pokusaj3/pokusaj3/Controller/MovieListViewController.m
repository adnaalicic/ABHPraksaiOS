//
//  ViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 19/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "MovieListViewController.h"
#import "CustomCellCollectionViewCell.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "SearchMovieListController.h"
#import "Movie.h"
#import "TMDbClass.h"
#import "LGSideMenuController/LGSideMenuController.h"
#import "LGSideMenuController/UIViewController+LGSideMenuController.h"

@interface MovieListViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *movieList;
@property (nonatomic) BOOL *searching;
@property (nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *optionsForSortingView;
@property (nonatomic) IBOutlet UIButton *mostPopularButton;
@property (nonatomic) IBOutlet UIButton *sortedByButton;
@property (nonatomic) IBOutlet UIButton *latestButton;
@property (nonatomic) IBOutlet UIButton *highestRatedButton;
@property (nonatomic, strong) NSMutableArray *listOfGenres;
@property (nonatomic) NSMutableArray *extendedMovieList;
@property int numberOfOption;
@property int page;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.listOfGenres = [[NSMutableArray alloc] init];
    self.extendedMovieList = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 677"]];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.textField.delegate = self;
    [self.optionsForSortingView setHidden:true];
    self.page = 1;
    self.isLogedIn = NO;
    
    [self.mostPopularButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected | UIControlStateHighlighted ];
    
    TMDbClass *tmbdClass = [[TMDbClass alloc] init];
    
    [tmbdClass getListOfPopularMoviesWithSuccess:^(NSArray *array) {
        self.movieList = array;
        [self.collectionView reloadData];
        for(int i = 0; i < self.movieList.count; i++){
            MovieDetails *tmp = self.movieList[i];

            
            [tmbdClass getMovieDetails:tmp.movieId withSuccess:^(NSArray *array) {
                MovieDetails *m = array[0];
                if(m.genresList.count){
                    Genre *g = m.genresList[0];
                    [self.listOfGenres addObject:g.name];}
            }];
        }
    }withPage:self.page];
    
    
    
    self.textField.placeholder = @"Search";
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    self.numberOfOption = 0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    int numberOfCellInRow = 2;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat cellWidth = (screenWidth*0.9)/numberOfCellInRow;
    CGFloat ratioOfWidthAndHeight = 1.7;
    
    return CGSizeMake(cellWidth, cellWidth * ratioOfWidthAndHeight);
}
#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.movieList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"CustomCell";
    CustomCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([self.movieList count]) {
        [cell setupWithMovie:[self.movieList objectAtIndex:indexPath.row]];
    }
    if(self.listOfGenres.count){
    [cell setupGenre:[self.listOfGenres objectAtIndex:indexPath.row]];
    }
//    if(indexPath.row == self.movieList.count -1){
//        TMDbClass *tmbdClass = [[TMDbClass alloc] init];
//        [tmbdClass getListOfPopularMoviesWithSuccess:^(NSArray *array) {
//            self.movieList = array;
//            for(int i = 0; i < array.count; i++){
//                MovieDetails *tmp = array[i];
//
//                [tmbdClass getMovieDetails:tmp.movieId withSuccess:^(NSArray *array) {
//                    MovieDetails *m = array[0];
//                    if(m.genresList.count){
//                        Genre *g = m.genresList[0];
//                        [self.listOfGenres addObject:g.name];}
//                }];
//            }
//            [collectionView reloadData];
//        } withPage:self.page];
//
//        self.page = self.page +1;
//    }
    return cell;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    [self performSegueWithIdentifier: @"showingSearchMovieList" sender: self];

}

-(IBAction)buttonOnOptionsTapped:(UIButton *)sender {
    TMDbClass *tmbdClass = [[TMDbClass alloc] init];
   
    switch (sender.tag) {
        case 0:
            //Most popular button clicked
            if([self.sortedByButton.titleLabel.text isEqualToString:@"Sorted by: Latest"]){
                [self.sortedByButton setTitle:@"Sorted by: Most popular" forState:UIControlStateNormal];
                [self moveCollectionUpAndIncreaseHeight];
                [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
                [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
                
                
            }
            else if([self.sortedByButton.titleLabel.text isEqualToString:@"Sorted by: Highest-rated"]){
                [self.sortedByButton setTitle:@"Sorted by: Most popular" forState:UIControlStateNormal];
                [self moveCollectionUpAndIncreaseHeight];
                [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
                [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
                
            }
            if(self.numberOfOption != 0){
                [tmbdClass getListOfPopularMoviesWithSuccess:^(NSArray *array) {
                    self.movieList = array;
                    [self.collectionView reloadData];
                    for(int i = 0; i < self.movieList.count; i++){
                        MovieDetails *tmp = self.movieList[i];
                        [tmbdClass getMovieDetails:tmp.movieId withSuccess:^(NSArray *array) {
                            MovieDetails *m = array[0];
                            [self.listOfGenres removeAllObjects];
                            if(m.genresList.count){
                                Genre *g = m.genresList[0];
                                
                                [self.listOfGenres addObject:g.name];}
                            }];
                    }
                } withPage:self.page];
            }
            self.numberOfOption = 0;
            break;
        case 1:
            //Latest button clicked
            if([self.sortedByButton.titleLabel.text isEqualToString:@"Sorted by: Most popular"]){
                [self.sortedByButton setTitle:@"Sorted by: Latest" forState:UIControlStateNormal];
                [self moveCollectionUpAndIncreaseHeight];
                [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
                [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
            
            }
            else if([self.sortedByButton.titleLabel.text isEqualToString:@"Sorted by: Highest-rated"]){
                [self.sortedByButton setTitle:@"Sorted by: Latest" forState:UIControlStateNormal];
                [self moveCollectionUpAndIncreaseHeight];
                [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
                [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
                
            }
            if(self.numberOfOption != 1){
                [self.listOfGenres removeAllObjects];
                [tmbdClass getListOfLatestMoviesWithSuccess:^(NSArray *array) {
                    self.movieList = array;
                    for(int i = 0; i < self.movieList.count; i++){
                        MovieDetails *tmp = self.movieList[i];

                        [tmbdClass getMovieDetails:tmp.movieId withSuccess:^(NSArray *array) {
                            MovieDetails *m = array[0];

                            if(m.genresList.count){
                                Genre *g = m.genresList[0];
                                [self.listOfGenres addObject:g.name];}
                        }];
                    }
                    [self.collectionView reloadData];
                }];
            }
            
            self.numberOfOption = 1;
            break;
        case 2:
            //Highest-rated button clicked
            if([self.sortedByButton.titleLabel.text isEqualToString:@"Sorted by: Most popular"]){
                [self.sortedByButton setTitle:@"Sorted by: Highest-rated" forState:UIControlStateNormal];
                [self moveCollectionUpAndIncreaseHeight];
                [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
                [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
               
            }
            else if([self.sortedByButton.titleLabel.text isEqualToString:@"Sorted by: Latest"]){
                [self.sortedByButton setTitle:@"Sorted by: Latest" forState:UIControlStateNormal];
                [self moveCollectionUpAndIncreaseHeight];
                [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
                [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
               
            }
            if(self.numberOfOption != 2){
                [self.listOfGenres removeAllObjects];
                [tmbdClass getListOfHighestRatedMoviesWithSuccess:^(NSArray *array) {
                    self.movieList = array;
                    for(int i = 0; i < self.movieList.count; i++){
                        MovieDetails *tmp = self.movieList[i];

                        [tmbdClass getMovieDetails:tmp.movieId withSuccess:^(NSArray *array) {
                            MovieDetails *m = array[0];
                           
                            if(m.genresList.count){
                                Genre *g = m.genresList[0];
                                [self.listOfGenres addObject:g.name];
                            }
                        }];
                    }
                    [self.collectionView reloadData];
                }];
            }
            self.numberOfOption = 2;
            break;
        case 3:
            //Sorted by button clicked
            [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
            if (self.optionsForSortingView.isHidden) {
                [self moveCollectionUpAndIncreaseHeight];
                [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
            }
            else {
                [self moveCollectionDownAndReduceHeight];
                [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 4.pgn"] forState:UIControlStateNormal];

            }
            break;
        default:
            break;
    }
}

-(void) moveCollectionDownAndReduceHeight {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.collectionView.frame;
        frame.origin.y = self.collectionView.frame.origin.y + 90.0;
        frame.size.height = self.collectionView.frame.size.height - 90.0;
        self.collectionView.frame = frame;
    }];

}
-(void) moveCollectionUpAndIncreaseHeight {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.collectionView.frame;
        frame.origin.y = self.collectionView.frame.origin.y - 90.0;
        frame.size.height = self.collectionView.frame.size.height + 90.0;
        self.collectionView.frame = frame;
    }];

    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showingDetailsFromCollection" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if( [segue.identifier isEqualToString:@"showingDetailsFromCollection"]){
        

        NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems][0];
        
        MovieDetailTableViewController *destViewController = segue.destinationViewController;
        MovieDetails *m = [self.movieList objectAtIndex:indexPath.row];
        
        destViewController.movieId= m.movieId;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
@end
