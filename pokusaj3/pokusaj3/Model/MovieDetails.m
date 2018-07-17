//
//  MovieDetails.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 05/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "MovieDetails.h"

@implementation MovieDetails

-(NSString *)voteAverageString{
    return [NSString stringWithFormat:@"%.1f", self.voteAverage];
}
- (NSURL *)fullPosterPath {
    if (self.backdrop) {
        NSString *tmp = @"http://image.tmdb.org/t/p/w300//";
        
        NSString *tmp2 = [tmp stringByAppendingString:self.backdrop];
        
        return [NSURL URLWithString:tmp2];
    }
    return nil;
}
- (NSURL *)fullPosterPathForCollection {
    if (self.backdrop) {
        NSString *tmp = @"http://image.tmdb.org/t/p/w300//";
        
        NSString *tmp2 = [tmp stringByAppendingString:self.posterPath];
        
        return [NSURL URLWithString:tmp2];
    }
    return nil;
}
-(NSString *)getDate{
    if(self.releaseDate.length == 10){
        NSRange range = NSMakeRange(0,4);
        NSString *year = [self.releaseDate substringWithRange:range];
        range = NSMakeRange(5,2);
        NSString *month = [self.releaseDate substringWithRange:range];
        range = NSMakeRange(8, 2);
        NSString *day = [self.releaseDate substringWithRange:range];
        if([month isEqualToString:@"01"]){
            month = @"January";
        }
        else if([month isEqualToString:@"02"]){
            month = @"February";
        }
        else if([month isEqualToString:@"03"]){
            month = @"March";
        }
        else if([month isEqualToString:@"04"]){
            month = @"April";
        }
        else if([month isEqualToString:@"05"]){
            month = @"May";
        }
        else if([month isEqualToString:@"06"]){
            month = @"June";
        }
        else if([month isEqualToString:@"07"]){
            month = @"July";
        }
        else if([month isEqualToString:@"08"]){
            month = @"August";
        }
        else if([month isEqualToString:@"09"]){
            month = @"September";
        }
        else if([month isEqualToString:@"10"]){
            month = @"October";
        }
        else if([month isEqualToString:@"11"]){
            month = @"November";
        }
        else if([month isEqualToString:@"12"]){
            month = @"December";
        }
        return [NSString stringWithFormat: @"%@ %@ %@", day, month, year];
        //return year;
        
    }
    return @" ";
}

- (MovieDetails *)setUpWithDictionary:(NSDictionary *)dictionary{
    MovieDetails *movie = [[MovieDetails alloc]init];
    movie.movieId = [dictionary objectForKey:@"id"];
    movie.shortDescription = [dictionary objectForKey:@"overview"];
    movie.posterPath = [dictionary objectForKey:@"poster_path"];
    movie.backdrop = [dictionary objectForKey:@"backdrop_path"];
    movie.releaseDate = [dictionary objectForKey:@"release_date"];
    movie.title = [dictionary objectForKey:@"title"];
    movie.movieLength = [dictionary objectForKey:@"runtime"];
    movie.voteAverage = [[dictionary objectForKey:@"vote_average"] floatValue];
    movie.genresList = [dictionary objectForKey:@"genres"];
    return movie;
}
@end
