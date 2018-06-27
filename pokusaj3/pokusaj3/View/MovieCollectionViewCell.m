//
//  MovieCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 12/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "MovieCollectionViewCell.h"

@implementation MovieCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    
    self.characterLabel.numberOfLines = 0;
    [self.characterLabel sizeToFit];
}

@end
