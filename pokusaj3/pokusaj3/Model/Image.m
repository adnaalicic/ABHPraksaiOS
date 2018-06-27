//
//  Image.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 08/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "Image.h"

@implementation Image
- (NSURL *)imagePath{
    if (self.filePath) {
        NSString *tmp = @"http://image.tmdb.org/t/p/w185//";
        
        NSString *tmp2 = [tmp stringByAppendingString:self.filePath];
        
        return [NSURL URLWithString:tmp2];
    }
    return nil;
}
@end
