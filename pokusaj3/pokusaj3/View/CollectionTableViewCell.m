//
//  CollectionTableViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 08/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "CollectionTableViewCell.h"

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setupWithDataSourceDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate position:(NSInteger)position{
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.tag = position;
    
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UINib *cellNibPoster = [UINib nibWithNibName:@"PosterInImageGalleryCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNibPoster forCellWithReuseIdentifier:@"PosterInImageGalleryCollectionViewCell"];
    
    UINib *cellNibActor = [UINib nibWithNibName:@"ActorCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNibActor forCellWithReuseIdentifier:@"ActorCollectionViewCell"];
    
    UINib *cellNibMovie = [UINib nibWithNibName:@"ActorsMovieCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNibMovie forCellWithReuseIdentifier:@"ActorsMovieCollectionViewCell"];
    [self setBackgroundColor:[UIColor blackColor]];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
}

@end
