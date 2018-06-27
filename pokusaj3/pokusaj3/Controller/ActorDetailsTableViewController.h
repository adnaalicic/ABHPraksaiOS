//
//  ActorDetailsTableViewController.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 12/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Actor.h"
#import "TMDbClass.h"
#import "ActorDetailsTableViewCell.h"
#import "ActorsMovieCollectionViewCell.h"


@interface ActorDetailsTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ActorDetailsTableViewCellDelegate>

@property (nonatomic, strong) NSString *actorId;
@property (nonatomic, strong) Actor *actor;
@property (nonatomic, strong) NSArray *movies;
-(IBAction)buttonPressed:(id)sender;
@property (nonatomic, strong) NSMutableArray *listOfCharacters;

@end
