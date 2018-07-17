//
//  CinemaSeatsViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 10/07/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleCollectionViewCell.h"
@interface CinemaSeatsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong) NSString *movieId;
@property (weak, nonatomic) IBOutlet UIView *viewWithCollection;
@property (strong) NSString *movieTitle;
@end
