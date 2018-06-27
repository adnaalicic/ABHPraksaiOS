//
//  PosterInImageGalleryCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 08/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "PosterInImageGalleryCollectionViewCell.h"

@implementation PosterInImageGalleryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (void)setupWithImage:(Image *)image{
  
    //self.posterImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.posterImageView sd_setImageWithURL:image.imagePath placeholderImage:nil];

}
@end
