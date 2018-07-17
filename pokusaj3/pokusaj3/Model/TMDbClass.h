//
//  TMDbClass.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 31/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "MovieDetails.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "SearchMovieListController.h"
#import "Genre.h"
#include "Actor.h"
#include "Credits.h"
#include "CrewMember.h"
#include "Image.h"
#include "Images.h"
#include "Review.h"
#include "Reviews.h"
#include "Authentication.h"
#import "Rate.h"
#import "Session.h"

@interface TMDbClass : NSObject
@property (strong, nonatomic) NSArray *movies;
@property (strong,nonatomic) NSString *apiKey;
@property (strong,nonatomic) NSString *keyPath;
@property (strong, nonatomic) NSString *pathPattern;

-(void) setupAPIandKeyPath;
-(void) getListOfPopularMoviesWithSuccess:(void (^)(NSArray *array))completionHandler withPage:(int)page;
-(void) getListOfLatestMoviesWithSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getListOfHighestRatedMoviesWithSuccess:(void (^)(NSArray *array))completionHandler;
//ispraviti naziv ove metode
-(void) getListOfMoviesWithSuccess:(void (^)(NSArray *array))completionHandler withQuery:(NSString *)query;
-(void) getMovieDetails:(NSString *) movieId withSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getMovieCredits:(NSString *) movieId withSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getMovieImages:(NSString *) movieId withSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getMovieReviews:(NSString *) movieId withSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getActor:(NSString *) actorId withSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getActorsMovies:(NSString *) actorId withSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getTokenWithSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getSession:(NSString *)token andUsername:(NSString *)username andPassword:(NSString *)password withSuccess:(void (^)(NSArray *array))completionHandler;


@end
