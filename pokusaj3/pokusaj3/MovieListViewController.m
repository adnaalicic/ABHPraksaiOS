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
#import "Movie.h"

@interface MovieListViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *movieList;
@property (nonatomic) NSString *pathPattern;
@property (nonatomic) NSString *keyPath;
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *query;
@property (nonatomic) BOOL *searching;
@property (nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *optionsForSortingView;
@property (nonatomic) IBOutlet UIButton *mostPopularButton;
@property (nonatomic) IBOutlet UIButton *sortedByButton;
@property (nonatomic) IBOutlet UIButton *latestButton;
@property (nonatomic) IBOutlet UIButton *highestRatedButton;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 677"]];
    self.collectionView.backgroundColor = [UIColor clearColor];
    //without this func sizeForItemAtIndexPath was not working, cause this class had no delegate ??
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.textField.delegate = self;
    [self.optionsForSortingView setHidden:true];
    [self setDataForTMDB];
    [self loadMovies];
    
    [self.mostPopularButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected | UIControlStateHighlighted ];
        /*[self.highestRatedButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected | UIControlStateHighlighted];
   [self.latestButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected | UIControlStateHighlighted];*/
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
    
    [cell setupWithMovie:[self.movieList objectAtIndex:indexPath.row]];
    
    
    return cell;
}
-(void) setDataForTMDB{
    self.pathPattern = @"/3/movie/popular";
    self.keyPath = @"results";
    self.apiKey = @"fe91a31c2346455531b30cddefc2105c";
    
    self.searching = false;
}
-(void) loadMovies{
   
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Movie class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"title" : @"title", @"release_date": @"releaseDate", @"poster_path" : @"posterPath", @"overview": @"overview", @"id":@"identity", @"vote_average":@"voteAverage"}];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams;
    if(!self.searching) {
        queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    }
    else {
        queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
        self.searching = false;
    }
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        //NSArray *movies = mappingResult.array;
        self.movieList = mappingResult.array;
        
        [self.collectionView reloadData];
       
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
   
    //[self.collectionView reloadData];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.themoviedb.org/3/search/movie?query=hard&api_key=fe91a31c2346455531b30cddefc2105c"]];
//    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
//    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
//        Movie *movie = [result firstObject];
//        NSLog(@"Mapped the movie: %@", movie.title);
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed with error: %@", [error localizedDescription]);
//    }];
//    [operation start];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.textField.text =@"";
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([self.textField.text isEqualToString:@""]){
        
    }
    else{
        self.query = self.textField.text;
        self.pathPattern = @"/3/search/movie";
        self.searching = true;
    }
    [self loadMovies];
    
}
-(IBAction)buttonOnOptionsTapped:(UIButton *)sender {
    NSString *stringForSortedBy = @"Sorted by: ";
    
    switch (sender.tag) {
        case 0:
            //most popular button selected
            [self.sortedByButton setTitle:[stringForSortedBy stringByAppendingString:@"Most popular"] forState:UIControlStateNormal];
            [self moveCollectionUpAndIncreaseHeight];
            [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
            printf("ovoo je prije slike %f", self.mostPopularButton.frame.size.width);
            [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
            [self.mostPopularButton setImage:[UIImage imageNamed:@"checked.pgn"] forState:UIControlStateNormal];
            [self.highestRatedButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.latestButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            CGRect frame = self.mostPopularButton.frame;
            frame.origin.x = frame.origin.x - 15.0;
            self.mostPopularButton.frame = frame;
            printf("ovoo je poslije slike %f", self.mostPopularButton.frame.size.width);
            

            break;
        case 1:
            [self.sortedByButton setTitle:[stringForSortedBy stringByAppendingString:@"Latest"] forState:UIControlStateNormal];
            [self moveCollectionUpAndIncreaseHeight];
            [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
            [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
            [self.mostPopularButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.highestRatedButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.latestButton setImage:[UIImage imageNamed:@"checked.pgn"] forState:UIControlStateNormal];
            break;
        case 2:
            [self.sortedByButton setTitle:[stringForSortedBy stringByAppendingString:@"Highest-rated"] forState:UIControlStateNormal];
            [self moveCollectionUpAndIncreaseHeight];
            [self.sortedByButton setImage:[UIImage imageNamed:@"Back Chevron Copy 3.pgn"] forState:UIControlStateNormal];
            [self.optionsForSortingView setHidden: !self.optionsForSortingView.isHidden];
            [self.mostPopularButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.highestRatedButton setImage:[UIImage imageNamed:@"checked.pgn"] forState:UIControlStateNormal];
            [self.latestButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            break;
        case 3:
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
@end
