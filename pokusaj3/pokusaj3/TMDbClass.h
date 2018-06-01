//
//  TMDbClass.h
//  pokusaj3
//
//  Created by Atlantbh Guest on 31/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "SearchMovieListController.h"

@interface TMDbClass : NSObject
@property (strong, nonatomic) NSArray *movies;
@property (strong,nonatomic) NSString *apiKey;
@property (strong,nonatomic) NSString *keyPath;
@property (strong, nonatomic) NSString *pathPattern;

-(void) setupAPIandKeyPath;
-(void) getListOfPopularMoviesWithSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getListOfLatestMoviesWithSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getListOfHighestRatedMoviesWithSuccess:(void (^)(NSArray *array))completionHandler;
-(void) getListOfMoviesWithSuccess:(void (^)(NSArray *array))completionHandler withQuery:(NSString *)query;

@end
