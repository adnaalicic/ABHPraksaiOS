//
//  ActorCollectionViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 08/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "ActorCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ActorCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.characterLabel.numberOfLines = 0;
    [self.characterLabel sizeToFit];
    
    self.nameLabel.numberOfLines = 0;
    [self.nameLabel sizeToFit];
    // Initialization code
}

-(void) setupWithActor:(Actor *)actor{
   
    [self.posterImageView sd_setImageWithURL:actor.imagePath placeholderImage:nil];
    self.nameLabel.text = actor.name;
    self.characterLabel.text = actor.character;
}

@end
