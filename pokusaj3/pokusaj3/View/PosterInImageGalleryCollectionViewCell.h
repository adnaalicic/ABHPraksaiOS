//
//  PosterInImageGalleryCollectionViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 08/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PosterInImageGalleryCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
-(void)setupWithImage :(Image *)image;
@end
