//
//  MovieDetails.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 05/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetails : NSObject
@property (nonatomic,strong) NSString *movieId;
//fali mi za put do videa?
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieLength;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSArray *genresList;
@property (nonatomic, strong) NSArray *actorsList;
@property (nonatomic, strong) NSArray *writersList;
@property (nonatomic) float voteAverage;
@property (nonatomic) NSString *genresString;
@property (nonatomic, strong) NSString *shortDescription;
@property (nonatomic, getter=voteAverageString) NSString *stringFormatOfVoteAverage;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, getter=fullPosterPath) NSURL *fullPosterPath;
@property (nonatomic, strong) NSString *backdrop;
@property (nonatomic, strong) NSArray *castList;
@property (nonatomic, strong) NSString *oneGenre;
- (NSURL *)fullPosterPathForCollection;
-(NSString *)getDate;
-(MovieDetails *)setUpWithDictionary:(NSDictionary *)dictionary;
@end
