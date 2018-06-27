//
//  User.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userPassword;
-(void) setUser;
@end
