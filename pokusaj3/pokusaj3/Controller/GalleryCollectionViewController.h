//
//  GalleryCollectionViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 13/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosterInImageGalleryCollectionViewCell.h"
#import "GalleryHeaderCollectionReusableView.h"

@interface GalleryCollectionViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *movieTitle;
@end
