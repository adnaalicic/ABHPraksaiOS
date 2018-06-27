//
//  Image.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 08/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
@property (nonatomic, strong) NSString *aspectRatio;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *voteAverage;
@property (nonatomic, strong) NSString *voteCount;
@property (nonatomic, strong) NSString *width;
-(NSURL *)imagePath;
@end
