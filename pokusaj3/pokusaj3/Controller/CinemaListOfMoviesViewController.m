//
//  CinemaListOfMoviesViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 09/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CinemaListOfMoviesViewController.h"
#import "CinemaMovieTableViewController.h"

@interface CinemaListOfMoviesViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *sortedByLabel;
@property (weak, nonatomic) IBOutlet UIView *sortedByView;
@property (nonatomic, readwrite) FIRFirestore *db;
@property (nonatomic) NSMutableArray *movies;
@property BOOL isMovedDown;


@end

@implementation CinemaListOfMoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  13.07.2018 u 17:00  1531501200
    // 13.07.2018 u 20:00 1531512000
    // 14.07.2018 u 17:00 1531587600
    // 14.07.2018 u 20:00 1531598400
    // 15.07.2018 u 17 1531674000
    //15.07.2018 u 20 1531684800
    //16 u 17 1531760400
    //16 u 20 1531771200
    //sideMenuController.leftViewWidth = 250.0;
    self.movies = [[NSMutableArray alloc]init];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.isMovedDown = NO;
    
    NSMutableArray *arrayOfSeats = [[NSMutableArray alloc]init];
    for(int i = 0; i < 110; i++){
        NSString *string = [[NSNumber numberWithInt:i]stringValue];
        [arrayOfSeats addObject:string];
    }
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithCapacity:110];
    for (int i = 0; i < 110; i++) {
        [dict setObject:[NSNumber numberWithInt:0] forKey:arrayOfSeats[i]];
    }
    
    UINib *cellNibBasic = [UINib nibWithNibName:@"CinemaMoviesCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:cellNibBasic forCellWithReuseIdentifier:@"CinemaMoviesCollectionViewCell"];
    [self.tableView setHidden:NO];
    self.sortedByLabel.numberOfLines = 0;
    [self.sortedByLabel sizeToFit];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.sortedByView addGestureRecognizer:singleFingerTap];
    
    self.db = [FIRFirestore firestore];
    
    
    [[self.db collectionWithPath:@"movies"]
     getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot,
                                  NSError * _Nullable error) {
         if (error != nil) {
             NSLog(@"Error getting documents: %@", error);
         } else {
             for (FIRDocumentSnapshot *document in snapshot.documents) {
                 NSLog(@"%@ => %@", document.documentID, document.data);
                 MovieDetails *m =[[MovieDetails alloc]init];
                 MovieDetails *m1 = [m setUpWithDictionary:document.data];
                 [self.movies addObject:m1];
//                 kada dodajem objekte u bazu
//                 FIRCollectionReference *moviesReference = [self.db collectionWithPath:@"cinema"];
//                 NSString *timeStamp = @"1531771200";
//                 NSString *add = [NSString stringWithFormat:@"%@%@",timeStamp,m1.movieId];
//                 [[moviesReference documentWithPath:add] setData:dict];
                //[self.collectionView reloadData];
             }
             
            
             [self.collectionView reloadData];
         }
     }];
    

    [[[self.db collectionWithPath:@"movies"] documentWithPath:@"Deadpool 2"]
     addSnapshotListener:^(FIRDocumentSnapshot *snapshot, NSError *error) {
         if (snapshot == nil) {
             NSLog(@"Error fetching document: %@", error);
             return;
         }
         NSString *source = snapshot.metadata.hasPendingWrites ? @"Local" : @"Server";
         NSLog(@" %@ data: %@", source, snapshot.data);
     }];
    
    [self.tableView setHidden:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Data source and delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movies.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CinemaMoviesCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CinemaMoviesCollectionViewCell" forIndexPath:indexPath];
    
    [cell setupWithMovie:[self.movies objectAtIndex:indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"showingCinemaMovieDetails" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showingCinemaMovieDetails"]){
        NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems][0];
        
        CinemaMovieTableViewController *destViewController = segue.destinationViewController;
        MovieDetails *m = [self.movies objectAtIndex:indexPath.row];
        destViewController.movieId = m.movieId;
        
        
    }
}
#pragma mark UIcollectionDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat cellWidth = (screenWidth*0.95);
    CGFloat ratioOfWidthAndHeight = 0.45;
    
    return CGSizeMake(cellWidth, cellWidth * ratioOfWidthAndHeight);
}

#pragma mark tableviewdatasource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init] ;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25,10,120,25)];
    NSLocale* currentLocale = [NSLocale currentLocale];
    [[NSDate date] descriptionWithLocale:currentLocale];
    switch (indexPath.row) {
        case 0:
            label.text = @"Today";
            break;
        case 1:
            label.text = @"14th July 2018";
            break;
        case 2:
            label.text = @"15th July 2018";
            break;
        case 3:
            label.text = @"16th July 2018";
            break;
        default:
            break;
    }
    
    [cell addSubview:label];
    cell.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"clicked %ld", indexPath.row);
    [self moveCollectionUp];

    //postaviti onu sliku da se mijenja
    //postaviti labelu sorted by da se mijenja
    switch (indexPath.row) {
        case 0:
            self.sortedByLabel.text = @"Today";
            break;
        case 1:
            self.sortedByLabel.text = @"14th July 2018";
            break;
        case 2:
            self.sortedByLabel.text = @"14th July 2018";
            break;
        case 3:
            self.sortedByLabel.text = @"15th July 2018";
            break;
        default:
            break;
    }
}
#pragma mark moving collection up and down
-(void) moveCollectionUp{
    [self.tableView setHidden:YES];

    self.isMovedDown = NO;
    CGRect frame = self.collectionView.frame;
    
    frame.origin.y = self.collectionView.frame.origin.y - 160.0;
    frame.size.height = self.collectionView.frame.size.height + 160.0;
    
    self.collectionView.frame = frame;
}
-(void) moveCollectionDown{
    
    [self.tableView setHidden:NO];
    self.isMovedDown = YES;
    CGRect frame = self.collectionView.frame;
    frame.origin.y = self.collectionView.frame.origin.y + 160.0;
    frame.size.height = self.collectionView.frame.size.height - 160.0;
    self.collectionView.frame = frame;
    
}
#pragma mark click on view
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if(!self.isMovedDown){
        [self moveCollectionDown];
        
    }
    else {
        [self moveCollectionUp];
        
    }
    NSLog(@"tapped");
    
}



@end
