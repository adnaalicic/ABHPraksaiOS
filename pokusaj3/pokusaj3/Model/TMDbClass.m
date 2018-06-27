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
//u oba mapiranja skontati kako za zanrove
-(RKObjectMapping *) mappingForMovies {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Movie class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"id" : @"identity",
                                                   @"title" : @"title",
                                                   @"release_date": @"releaseDate",
                                                   @"poster_path" : @"posterPath",
                                                   @"overview": @"overview",
                                                   @"id":@"identity",
                                                   @"vote_average": @"voteAverage",
                                                   }];
    [mapping addPropertyMapping:[RKRelationshipMapping
                                 relationshipMappingFromKeyPath:@"genres" toKeyPath:@"genresList" withMapping:[self mappingForGenres]]];
    return mapping;
}
-(RKObjectMapping *) mappingForGenres {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Genre class]];
    [mapping addAttributeMappingsFromDictionary:@{@"name" : @"name", @"id" : @"genreId"}];
    return mapping;
}
-(RKObjectMapping *) mappingForMovieDetails {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[MovieDetails class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"title" : @"title",
                                                   @"release_date": @"releaseDate",
                                                   @"overview": @"shortDescription",
                                                   @"vote_average":@"voteAverage",
                                                   @"runtime":@"movieLength",
                                                   @"poster_path" : @"posterPath",
                                                   @"backdrop_path":@"backdrop",
                                                   @"id":@"movieId"}];
    
    [mapping addPropertyMapping:[RKRelationshipMapping
                                 relationshipMappingFromKeyPath:@"genres" toKeyPath:@"genresList" withMapping:[self mappingForGenres]]];
    
    return mapping;
}



-(void) getListOfPopularMoviesWithSuccess:(void (^)(NSArray *array))completionHandler withPage:(int)page {
    
    self.pathPattern = @"/3/movie/popular";
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForMovieDetails];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams;
    NSString *pageString = [NSString stringWithFormat:@"%i", page];
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", pageString, @"page",nil];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completionHandler(mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];

   
}

-(void) getListOfHighestRatedMoviesWithSuccess:(void (^)(NSArray *array))completionHandler{
    self.pathPattern = @"/3/movie/top_rated";
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForMovieDetails];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
//ovdje mi ne radi api iz nekog razloga
-(void) getListOfLatestMoviesWithSuccess:(void (^)(NSArray *array))completionHandler{

    self.pathPattern = @"/3/movie/upcoming";
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForMovieDetails];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        completionHandler(mappingResult.array);
    
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
-(void) getListOfMoviesWithSuccess:(void (^)(NSArray *array))completionHandler withQuery:(NSString *)query{
    self.pathPattern = @"/3/search/movie";
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForMovies];
    
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
-(void) getMovieDetails:(NSString *) movieId withSuccess:(void (^)(NSArray *array))completionHandler{
    //nije mi radilo samo sa appending string
    NSString *pathPattertPartOne = @"/3/movie/";
    self.pathPattern = [NSString stringWithFormat: @"%@%@", pathPattertPartOne, movieId];

    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForMovieDetails];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:nil statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
       
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark Mapping for credits - Actors and Crew
-(RKObjectMapping *) mappingForActors {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Actor class]];
    [mapping addAttributeMappingsFromDictionary:@{@"cast_id" : @"castId",
                                                  @"character" : @"character",
                                                  @"credit_id" : @"creditId",
                                                  @"gender" : @"gender",
                                                  @"id" : @"actorId",
                                                  @"name" : @"name",
                                                  @"order" : @"order",
                                                  @"profile_path" : @"profilePath"}];
    return mapping;
}
-(RKObjectMapping *) mappingForCrew {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CrewMember class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"credit_id" : @"creditId",
                                                  @"department" : @"department",
                                                  @"gender" : @"gender",
                                                  @"id" : @"crewMemberId",
                                                  @"job" : @"job",
                                                  @"name" : @"name",
                                                  @"profile_path" : @"profilePath"}];
    return mapping;
}
-(RKObjectMapping *) mappingForMovieDetailsCredits {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Credits class]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"cast" toKeyPath:@"actorsList" withMapping:[self mappingForActors]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"crew" toKeyPath:@"crewList" withMapping:[self mappingForCrew]]];
    return mapping;
}
-(void) getMovieCredits:(NSString *) movieId withSuccess:(void (^)(NSArray *array))completionHandler{
    //nije mi radilo samo sa appending string
    NSString *pathPattertPartOne = @"/3/movie/";
    NSString *creditsPart = @"/credits";
    self.pathPattern = [NSString stringWithFormat: @"%@%@%@", pathPattertPartOne, movieId,creditsPart];
    
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForMovieDetailsCredits];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:nil statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark Mapping images
-(RKObjectMapping *) mappingForImage {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Image class]];
    [mapping addAttributeMappingsFromDictionary:@{@"aspect_ratio" : @"aspectRatio",
                                                  @"file_path" : @"filePath",
                                                  @"height" : @"height",
                                                  @"vote_average" : @"voteAverage",
                                                  @"vote_count" : @"voteCount",
                                                  @"width" : @"width"}];
    return mapping;
}
-(RKObjectMapping *) mappingForImages {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Images class]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"backdrops" toKeyPath:@"backdropList" withMapping:[self mappingForImage]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"posters" toKeyPath:@"postersList" withMapping:[self mappingForImage]]];
    return mapping;
}
-(void) getMovieImages:(NSString *) movieId withSuccess:(void (^)(NSArray *array))completionHandler{
    //nije mi radilo samo sa appending string
    NSString *pathPattertPartOne = @"/3/movie/";
    NSString *imagesPart = @"/images";
    self.pathPattern = [NSString stringWithFormat: @"%@%@%@", pathPattertPartOne, movieId,imagesPart];
    
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForImages];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:nil statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark Mapping reviews
-(RKObjectMapping *) mappingForReview {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Review class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id" : @"reviewId",
                                                  @"author" : @"author",
                                                  @"content" : @"content",
                                                  @"url" : @"url",
                                                  }];
    return mapping;
}
-(RKObjectMapping *) mappingForReviews {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Reviews class]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"results" toKeyPath:@"reviewsList" withMapping:[self mappingForReview]]];
    
    return mapping;
}
-(void) getMovieReviews:(NSString *) movieId withSuccess:(void (^)(NSArray *array))completionHandler{
    //nije mi radilo samo sa appending string
    NSString *pathPattertPartOne = @"/3/movie/";
    NSString *reviewsPart = @"/reviews";
    self.pathPattern = [NSString stringWithFormat: @"%@%@%@", pathPattertPartOne, movieId,reviewsPart];
    
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForReviews];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:nil statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark Mapping for Actors witht details
-(RKObjectMapping *) mappingForActorsDetails {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Actor class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id" : @"actorId",
                                                  @"gender" : @"gender",
                                                  @"name" : @"name",
                                                  @"biography" : @"biography",
                                                  @"birthday" : @"birthday",
                                                  @"homepage" : @"homepage",
                                                  @"place_of_birth" : @"placeOfBirth",
                                                  @"profile_path" : @"profilePath"
                                                  }];
    return mapping;
}
-(void) getActor:(NSString *) actorId withSuccess:(void (^)(NSArray *array))completionHandler{
    NSString *pathPattertPartOne = @"/3/person/";
   
    self.pathPattern = [NSString stringWithFormat: @"%@%@", pathPattertPartOne,actorId];
    
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForActorsDetails];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:nil statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}

-(void) getActorsMovies:(NSString *) actorId withSuccess:(void (^)(NSArray *array))completionHandler{
    
    self.pathPattern = @"/3/discover/movie";
    
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForMovieDetails];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:self.keyPath statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", actorId, @"with_cast", nil];
    
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}

-(RKObjectMapping *) mappingForAuthentication {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Authentication class]];
    [mapping addAttributeMappingsFromDictionary:@{@"success" : @"success",
                                                  @"expires_at" : @"expiresAt",
                                                  @"request_token" : @"requestToken",
                                                  }];
    return mapping;
}
-(void) getTokenWithSuccess:(void (^)(NSArray *array))completionHandler{
    
    self.pathPattern = @"/3/authentication/token/new";
    
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForAuthentication];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:nil statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
-(RKObjectMapping *) mappingForAuthenticationLogin {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Authentication class]];
    [mapping addAttributeMappingsFromDictionary:@{@"success" : @"success",
                                                  @"request_token" : @"requestToken",
                                                  }];
    return mapping;
}
-(void) getTokenWithUsername:(NSString *)username andPassword:(NSString *)password withSuccess:(void (^)(NSArray *array))completionHandler{
    
    self.pathPattern = @"/3/authentication/token/new";
    
    [self setupAPIandKeyPath];
    RKObjectMapping *mapping = [self mappingForAuthentication];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:self.pathPattern keyPath:nil statusCodes:statusCodes];
    
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    //NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:self.query, @"query", self.apiKey, @"api_key", nil];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys: self.apiKey, @"api_key", nil];
    
    
    
    [[RKObjectManager sharedManager] getObjectsAtPath:self.pathPattern parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completionHandler(mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];
}
@end
