//
//  Authentication.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 27/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Authentication : NSObject
@property (strong, nonatomic) NSString *success;
@property (strong, nonatomic) NSString *expiresAt;
@property (strong, nonatomic) NSString *requestToken;

@end
