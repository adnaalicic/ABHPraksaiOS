//
//  ActorCollectionViewCell.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 08/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Actor.h"

@interface ActorCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *characterLabel;

-(void) setupWithActor:(Actor *)actor;
@end
