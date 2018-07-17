//
//  CinemaSeatsViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 10/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CinemaSeatsViewController.h"
@import Firebase;

@interface CinemaSeatsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) int numberOfSeatsInRow;
@property (strong, nonatomic) NSMutableArray *seatsSelected;
@property NSInteger maxNumberOfSeats;
@property (weak, nonatomic) IBOutlet UIView *takenView;
@property (weak, nonatomic) IBOutlet UIView *availableView;
@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (strong) NSString *timestamp;
@property (strong) NSDictionary *dictionary;
@property (nonatomic, readwrite) FIRFirestore *db;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;
@property (weak, nonatomic) IBOutlet UIView *dateTimeView;
@property (weak, nonatomic) IBOutlet UIView *peopleView;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property BOOL movedDown;
@property (weak, nonatomic) IBOutlet UIPickerView *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *peoplePicker;
@property (strong, nonatomic) NSArray *timesArray;
@property (strong, nonatomic) NSArray *peopleArray;
@property (strong, nonatomic) NSString *pickedPeople;
@property (strong, nonatomic) NSString *pickedTime;
@end

@implementation CinemaSeatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.seatsSelected = [[NSMutableArray alloc]init];
    self.movedDown = NO;
    UINib *cellNib = [UINib nibWithNibName:@"CircleCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CircleCollectionViewCell"];
    
    self.numberOfSeatsInRow = 0;
    self.maxNumberOfSeats = 5;
    
    self.datePicker.delegate = self;
    self.datePicker.dataSource = self;
    self.peoplePicker.delegate = self;
    self.peoplePicker.dataSource = self;
    [self.datePicker setHidden:YES];
    [self.peoplePicker setHidden:YES];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.dateTimeView addGestureRecognizer:singleFingerTap];
    UITapGestureRecognizer *singleFingerTapPeople =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapPeople:)];
    [self.peopleView addGestureRecognizer:singleFingerTapPeople];
  
    
    CGRect frame = self.takenView.frame;
    self.takenView.layer.cornerRadius = frame.size.height/2;
    
    self.availableView.layer.cornerRadius = self.availableView.frame.size.height/2;
    self.selectedView.layer.cornerRadius = self.selectedView.frame.size.height/2;
    
    self.movieTitleLabel.text = self.movieTitle;
    
    
    NSString *date = [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedDate"];
    NSString *time = [NSString stringWithFormat:@"%@", @"17:00"];
    NSString *futurTimeLabel = [NSString stringWithFormat:@"%@ - %@",date,time];
    self.dateTimeLabel.text = futurTimeLabel;
    NSString *time2 = [NSString stringWithFormat:@"%@", @"20:00"];
    NSString *secondTime =[NSString stringWithFormat:@"%@ - %@",date,time2];
    self.timesArray = @[futurTimeLabel, secondTime];
    self.peopleArray = @[@"1 Adult",@"2 Adults",@"3 Adults",@"4 Adults",@"5 Adults"];
    
    [self setTimeStampWithDate:futurTimeLabel];
    NSString *collectionId = [[NSString alloc]init];
    collectionId =[NSString stringWithFormat:@"%@%@",self.timestamp,self.movieId];
    self.db = [FIRFirestore firestore];
    
    
    FIRDocumentReference *docRef =
    [[self.db collectionWithPath:@"cinema"] documentWithPath:collectionId];
    [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
        if (snapshot.exists) {
            // Document data may be nil if the document exists but has no keys or values.
            NSLog(@"Document data: %@", snapshot.data);
            self.dictionary = snapshot.data;
            self.numberOfSeatsInRow = 0;
            [self.collectionView reloadData];
        } else {
            NSLog(@"Document does not exist");
        }
    }];
    
    [[[self.db collectionWithPath:@"cinema"] documentWithPath:collectionId]
     addSnapshotListener:^(FIRDocumentSnapshot *snapshot, NSError *error) {
         if (snapshot == nil) {
             NSLog(@"Error fetching document: %@", error);
             return;
         }
         NSString *source = snapshot.metadata.hasPendingWrites ? @"Local" : @"Server";
         NSLog(@" %@ data: %@", source, snapshot.data);
         self.dictionary = snapshot.data;
         self.numberOfSeatsInRow = 0;
         [self.collectionView reloadData];
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CollectionView DataSource and Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dictionary.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CircleCollectionViewCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor redColor];
    if(self.numberOfSeatsInRow + 11 < indexPath.row){
        self.numberOfSeatsInRow = self.numberOfSeatsInRow +11;
    }
    
    if(indexPath.row != 0 && indexPath.row != 10 &&  indexPath.row != self.numberOfSeatsInRow+2 && indexPath.row != self.numberOfSeatsInRow+8 ){
        NSString *key = [[NSNumber numberWithInteger:indexPath.row] stringValue];
        if([[self.dictionary objectForKey:key] isEqual:[NSNumber numberWithInt:0]]){
            [cell setCircleWithColor:[UIColor whiteColor]];
        }
        else {
            [cell setCircleWithColor:[UIColor darkGrayColor]];

        }
        return cell;
    }
    [cell setCircleWithColor:[UIColor clearColor]];

    return cell;
    
}

#pragma mark CollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat cellWidth = (screenWidth)/17;
    
    return CGSizeMake(cellWidth, cellWidth );
}
    
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if([self.pickedPeople isEqualToString:@"1 Adult"]){
        self.maxNumberOfSeats = 1;
    }
    else if([self.pickedPeople isEqualToString:@"2 Adults"]){
        self.maxNumberOfSeats = 2;

    }
    else if([self.pickedPeople isEqualToString:@"3 Adults"]){
        self.maxNumberOfSeats = 3;
        
    }
    else if([self.pickedPeople isEqualToString:@"4 Adults"]){
        self.maxNumberOfSeats = 4;
        
    }
    else if([self.pickedPeople isEqualToString:@"5 Adults"]){
        self.maxNumberOfSeats = 5;
        
    }
    
    if(indexPath.row != 0 && indexPath.row != 10 &&  indexPath.row != self.numberOfSeatsInRow+2 && indexPath.row != self.numberOfSeatsInRow+8 ){
        
        if([[self.dictionary objectForKey:[[NSNumber numberWithInteger:indexPath.row] stringValue]] isEqual:[NSNumber numberWithInt:0]]){
        if(![self.seatsSelected containsObject:[NSNumber numberWithInteger:indexPath.row]]){
            if(self.maxNumberOfSeats > self.seatsSelected.count){
            [self.seatsSelected addObject:[NSNumber numberWithInteger:indexPath.row]];
            
            UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
            [(CircleCollectionViewCell *)cell setSelectOrDeselect];
            }
        }
        else {
            [self.seatsSelected removeObject:[NSNumber numberWithInteger:indexPath.row]];
            
            UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
            [(CircleCollectionViewCell *)cell setSelectOrDeselect];
        }
        NSLog(@"%ld",self.seatsSelected.count);
        }
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if(!self.movedDown){
        [self.datePicker setHidden:NO];
        [self moveViewWithCollectionDown];
    }
    else{
        [self.datePicker setHidden:YES];

        [self moveViewWithCollectionUp];
    }
    NSLog(@"tapped");
    
}
- (void)handleSingleTapPeople:(UITapGestureRecognizer *)recognizer
{
    if(!self.movedDown){
        [self moveViewWithCollectionDown];
        [self.peoplePicker setHidden:NO];
    }
    else{
        [self moveViewWithCollectionUp];
        [self.peoplePicker setHidden:YES];
    }
    NSLog(@"tappedPeople");
    
}


-(void) moveViewWithCollectionUp{
    CGRect frame = self.viewWithCollection.frame;
    frame.origin.y = self.viewWithCollection.frame.origin.y - 100;
    self.viewWithCollection.frame = frame;
    self.movedDown = NO;


}
-(void)moveViewWithCollectionDown{
    CGRect frame = self.viewWithCollection.frame;
    frame.origin.y = self.viewWithCollection.frame.origin.y + 100;
    self.viewWithCollection.frame = frame;
    
    self.movedDown = YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 1){
        return 2;
    }
    return 5;
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 1){
        return self.timesArray[row];
    }
    return self.peopleArray[row];
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;

    if(pickerView.tag == 1){
        title= self.timesArray[row];
    }
    else{
        title =self.peopleArray[row];

    }
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag == 1){
        self.pickedTime = self.timesArray[row];
        self.dateTimeLabel.text = self.pickedTime;
        [self setTimeStampWithDate:self.pickedTime];
        [self getDataFromDB];
        
    }
    else {
        self.pickedPeople = self.peopleArray[row];
        self.numberOfPeopleLabel.text = self.pickedPeople;
    }
    [self moveViewWithCollectionUp];
    [self.peoplePicker setHidden:YES];
    [self.datePicker setHidden:YES];
    self.seatsSelected = [[NSMutableArray alloc]init];
    self.numberOfSeatsInRow = 0;

    [self.collectionView reloadData];
}
-(void)setTimeStampWithDate:(NSString *)time{
    if([time isEqualToString:@"13/07/2018 - 17:00"]){
        self.timestamp = @"1531501200";
    }
    else if([time isEqualToString:@"13/07/2018 - 20:00"]){
        self.timestamp = @"1531512000";

    }
    else if([time isEqualToString:@"14/07/2018 - 17:00"]){
        self.timestamp = @"1531587600";

    }
    else if([time isEqualToString:@"14/07/2018 - 20:00"]){
        self.timestamp = @"1531598400";

    }
    else if([time isEqualToString:@"15/07/2018 - 17:00"]){
        self.timestamp = @"1531674000";
    }
    else if([time isEqualToString:@"15/07/2018 - 20:00"]){
        self.timestamp = @"1531684800";

    }
    else if([time isEqualToString:@"16/07/2018 - 17:00"]){
        self.timestamp = @"1531760400";
    }
    else if([time isEqualToString:@"16/07/2018 - 20:00"]){
        self.timestamp = @"1531771200";
    }
    
}
- (IBAction)buttonPressed:(id)sender {
    for (int i = 0; i < self.seatsSelected.count; i++) {
        [self.dictionary setValue:[NSNumber numberWithInteger:1] forKey:[self.seatsSelected[i] stringValue]];
    }
    NSString *collectionId = [[NSString alloc]init];
    collectionId =[NSString stringWithFormat:@"%@%@",self.timestamp,self.movieId];
    FIRCollectionReference *moviesReference = [self.db collectionWithPath:@"cinema"] ;
    
                     [[moviesReference documentWithPath:collectionId] setData:self.dictionary];
    [self performSegueWithIdentifier:@"showingPayment" sender:self];
    self.seatsSelected = [[NSMutableArray alloc]init];
    self.numberOfSeatsInRow = 0;

}
-(void)getDataFromDB{
    NSString *collectionId = [[NSString alloc]init];
    collectionId =[NSString stringWithFormat:@"%@%@",self.timestamp,self.movieId];
    self.seatsSelected = [[NSMutableArray alloc]init];
    FIRDocumentReference *docRef =
    [[self.db collectionWithPath:@"cinema"] documentWithPath:collectionId];
    [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
        if (snapshot.exists) {
            NSLog(@"Document data: %@", snapshot.data);
            self.dictionary = snapshot.data;
            self.numberOfSeatsInRow = 0;
            [self.collectionView reloadData];
        } else {
            NSLog(@"Document does not exist");
        }
    }];
}
@end
