//
//  ActorDetailsTableViewCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 12/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "ActorDetailsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation ActorDetailsTableViewCell
{
    CAGradientLayer *gradientMask;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dateOfBirthLabel.numberOfLines = 0;
    [self.dateOfBirthLabel sizeToFit];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setupWithActor:(Actor *)actor extended:(BOOL)isExtended andDelegate:(id<ActorDetailsTableViewCellDelegate>)delegate{
    self.delegate = delegate;
    self.nameLabel.text = actor.name;
    self.websiteLabel.text = actor.homepage;
    self.biographyLabel.text = actor.biography;
    self.dateOfBirthLabel.text = actor.birthday;
    if(isExtended){
        self.biographyLabel.numberOfLines = 0;
        [self.biographyLabel sizeToFit];
        self.seeFullBioButton.titleLabel.text = @"See less bio";
    }
    else{
         self.biographyLabel.numberOfLines = 4;
        self.seeFullBioButton.titleLabel.text = @"See full bio";

    }
   
    [self.pictureImageView sd_setImageWithURL:actor.imagePathBig placeholderImage:nil];
   [self setGradient];

//    self.biographyLabel.numberOfLines = isExtended ? 0 : 4;
   
//    [self.biographyLabel sizeToFit];
    
}
-(void) setGradient {
    if(gradientMask == nil){
        gradientMask = [CAGradientLayer layer];
        CGRect futureFrame = self.bounds;
        futureFrame.size.width =[[UIScreen mainScreen]bounds].size.width;
        gradientMask.frame = futureFrame;
        
        //gradientMask.frame.size.width = [[UIScreen mainScreen]bounds].size.width;
        gradientMask.locations = @[@0.02, @0.5];
        gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
                                (id)[UIColor blackColor].CGColor];
        //self.backgroundColor = [UIColor clearColor];
        [self.pictureImageView.layer insertSublayer:gradientMask atIndex:0];
    }
}
- (IBAction)showFullBio:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(showFullBio)]){
        [self.delegate performSelector:@selector(showFullBio) withObject:nil];
    }
}

@end
