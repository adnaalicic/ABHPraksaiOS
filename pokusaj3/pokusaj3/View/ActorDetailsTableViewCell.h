//
//  ActorDetailsTableViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 12/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Actor.h"

@protocol ActorDetailsTableViewCellDelegate <NSObject>
-(void)showFullBio;
@end

@interface ActorDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *biographyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeFullBioButton;
@property (weak, nonatomic) id<ActorDetailsTableViewCellDelegate> delegate;
-(void) setupWithActor:(Actor *)actor extended:(BOOL)isExtended andDelegate:(id<ActorDetailsTableViewCellDelegate>)delegate;

@end
