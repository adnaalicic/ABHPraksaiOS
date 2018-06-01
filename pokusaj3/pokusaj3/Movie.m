//
//  Movie.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 25/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "Movie.h"

@implementation Movie


- (NSURL *)fullPosterPath {
    if (self.posterPath) {
        NSString *tmp = @"http://image.tmdb.org/t/p/w185//";
        
        NSString *tmp2 = [tmp stringByAppendingString:self.posterPath];
        
        return [NSURL URLWithString:tmp2];
    }
    return nil;
}
-(NSString *) getDateOfRelease {
    
    return _releaseDate;
}
-(NSString *)voteAverageString{
    return [NSString stringWithFormat:@"%.1f", self.voteAverage];
}
@end
