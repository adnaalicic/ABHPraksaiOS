//
//  TMDbClass.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 31/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "TMDbClass.h"

@implementation TMDbClass

- (void)setupAPIandKeyPath {
    self.apiKey = @"fe91a31c2346455531b30cddefc2105c";
    self.keyPath = @"results";
    
}

-(void) getListOfPopularMoviesWithSuccess:(void (^)(NSArray *array))completionHandler {
    self.pathPattern = @"/3/movie/popular";
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Movie class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"title" : @"title", @"release_date": @"releaseDate", @"poster_path" : @"posterPath", @"overview": @"overview", @"id":@"identity", @"vote_average":@"voteAverage"}];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        self.movies = mappingResult.array;
        completionHandler(mappingResult.array);
        
        
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];

   
}

-(void) getListOfHighestRatedMoviesWithSuccess:(void (^)(NSArray *array))completionHandler{
    self.pathPattern = @"/3/movie/top_rated";
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Movie class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"title" : @"title", @"release_date": @"releaseDate", @"poster_path" : @"posterPath", @"overview": @"overview", @"id":@"identity", @"vote_average":@"voteAverage"}];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        self.movies = mappingResult.array;
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
//ovdje mi ne radi api iz nekog razloga
-(void) getListOfLatestMoviesWithSuccess:(void (^)(NSArray *array))completionHandler{

    self.pathPattern = @"/3/movie/latest";
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Movie class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"title" : @"title", @"release_date": @"releaseDate", @"poster_path" : @"posterPath", @"overview": @"overview", @"id":@"identity", @"vote_average":@"voteAverage"}];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        self.movies = mappingResult.array;
        completionHandler(mappingResult.array);
    
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
-(void) getListOfMoviesWithSuccess:(void (^)(NSArray *array))completionHandler withQuery:(NSString *)query{
    self.pathPattern = @"/3/search/movie";
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Movie class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"title" : @"title", @"release_date": @"releaseDate", @"poster_path" : @"posterPath", @"overview": @"overview", @"id":@"identity", @"vote_average":@"voteAverage"}];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:query, @"query", self.apiKey, @"api_key", nil];
  
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        completionHandler(mappingResult.array);

        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}

@end
