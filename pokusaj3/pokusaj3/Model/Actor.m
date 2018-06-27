//
//  Actor.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 07/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "Actor.h"

@implementation Actor
- (NSURL *)imagePath{
    if (self.profilePath) {
        NSString *tmp = @"http://image.tmdb.org/t/p/w185//";
        
        NSString *tmp2 = [tmp stringByAppendingString:self.profilePath];
        
        return [NSURL URLWithString:tmp2];
    }
    return nil;
}
- (NSURL *)imagePathBig{
    if (self.profilePath) {
        NSString *tmp = @"http://image.tmdb.org/t/p/w300//";
        
        NSString *tmp2 = [tmp stringByAppendingString:self.profilePath];
        
        return [NSURL URLWithString:tmp2];
    }
    return nil;
}

@end
