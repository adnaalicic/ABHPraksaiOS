//
//  GalleryCollectionViewController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 13/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "GalleryCollectionViewController.h"

@interface GalleryCollectionViewController ()

@end

@implementation GalleryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    UINib *headerCell = [UINib nibWithNibName:@"GalleryHeaderCollectionReusableView" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:headerCell forCellWithReuseIdentifier:@"GalleryHeaderCollectionReusableView"];
    
    UINib *cellNibBasic = [UINib nibWithNibName:@"PosterInImageGalleryCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:cellNibBasic forCellWithReuseIdentifier:@"PosterInImageGalleryCollectionViewCell"];
    self.collectionView.backgroundColor=[UIColor blackColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
     GalleryHeaderCollectionReusableView *header = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:@"GalleryHeaderCollectionReusableView"
                                                           forIndexPath:indexPath];
        NSString *numberOfImages = [NSString stringWithFormat:@"%li", self.images.count];
        header.numberOfImagesLabel.text = [NSString stringWithFormat: @"%@ images", numberOfImages];
        header.titleLabel.text = [NSString stringWithFormat: @"Image gallery: %@", self.movieTitle];
        
    }
    
    return header;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PosterInImageGalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PosterInImageGalleryCollectionViewCell" forIndexPath:indexPath];
    [cell setupWithImage:[self.images objectAtIndex:indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float numberOfCellInRow = 3.01;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat cellWidth = screenWidth/numberOfCellInRow;
    CGFloat ratioOfWidthAndHeight = 1.2;
    
    return CGSizeMake(cellWidth, cellWidth * ratioOfWidthAndHeight);

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.001;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.001;
}


#pragma mark <UICollectionViewDelegate>



@end
