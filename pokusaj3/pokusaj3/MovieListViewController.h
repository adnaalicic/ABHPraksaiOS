//
//  ViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 19/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieListViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@end

