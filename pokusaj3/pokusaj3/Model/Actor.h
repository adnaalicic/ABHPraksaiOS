//
//  Actor.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 07/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Actor : NSObject

@property (nonatomic,strong) NSString *castId;
@property (nonatomic,strong) NSString *character;
@property (nonatomic,strong) NSString *creditId;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *actorId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *order;
@property (nonatomic,strong) NSString *profilePath;
@property (nonatomic,strong) NSString *biography;
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *homepage;
@property (nonatomic,strong) NSString *placeOfBirth;
-(NSURL *)imagePath;
-(NSURL *)imagePathBig;

@end
