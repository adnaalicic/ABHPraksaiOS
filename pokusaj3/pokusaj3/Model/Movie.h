//
//  Movie.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 25/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject


@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSString *identity;
@property (nonatomic, strong) NSArray *genresList;
@property (nonatomic) float voteAverage;

@property (nonatomic, getter=fullPosterPath) NSURL *fullPosterPath;
@property (nonatomic, getter=voteAverageString) NSString *stringFormatOfVoteAverage;
-(NSString *) getDate;
@end
