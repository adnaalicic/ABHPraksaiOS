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

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //without this func sizeForItemAtIndexPath was not working, cause this class had no delegate ??
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self loadMovies];
    
   
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
    NSLog(@"broj je %d",self.movieList.count);
    return self.movieList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    printf("ovdje");
    static NSString *cellIdentifier = @"CustomCell";
    CustomCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell setupWithMovie:[self.movieList objectAtIndex:indexPath.row]];
    
    printf("ovdj2");
    return cell;
}

-(void) loadMovies{
    NSLog(@"prvo ovooooooo");
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Movie class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"title" : @"title", @"release_date": @"releaseDate", @"poster_path" : @"posterPath", @"overview": @"overview", @"id":@"identity", @"vote_average":@"voteAverage"}];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:@"/3/search/movie" keyPath:@"results" statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:@"hard", @"query", @"fe91a31c2346455531b30cddefc2105c", @"api_key", nil];
    

    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/3/search/movie" parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSArray *movies = mappingResult.array;
        self.movieList = mappingResult.array;
        NSLog(@"broj u funkciji je je %d",self.movieList.count);
        for (Movie *movie in movies) {
            //NSLog(@"Title: %@", movie.title);
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        
        
        
    }];
    
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


@end
