//
//  AJWMovieController.m
//  MovieDataBaseOBJC
//
//  Created by Austin West on 5/24/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import "AJWMovieController.h"

static NSString * const baseUrlString = @"https://api.themoviedb.org/3/search/movie";
static NSString * const baseImageUrl = @"https://image.tmdb.org/t/p/w500";
static NSString * const query = @"query";
static NSString * const api = @"api_key";
static NSString * const apiKey = @"5ea295b9c220e17b10a8f5d6c5b866cb";

@implementation AJWMovieController

// SOT

+ (instancetype)sharedInstance
{
    static AJWMovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [AJWMovieController new];
    });
    return sharedInstance;
}

-(void)fetchMoviesWithSearch:(NSString *)search completion:(void (^)(NSArray<AJWMovie *> *))completion
{
    //    create url
    NSURL *baseUrl = [NSURL URLWithString:baseUrlString];
    NSURLQueryItem *apiQuery = [[NSURLQueryItem alloc] initWithName:api value:apiKey];
    NSURLQueryItem *searchQuery = [[NSURLQueryItem alloc] initWithName:query value:search];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseUrl resolvingAgainstBaseURL:TRUE];
    components.queryItems = [[NSArray alloc] initWithObjects:(apiQuery), (searchQuery), nil];
    NSURL *finalUrl = components.URL;
    
    NSLog(@"%@", [finalUrl absoluteString]);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (data) {
            NSDictionary *jsonTopLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            if (!jsonTopLevelDictionary) {
                NSLog(@"Error parsing json data top");
                completion(nil);
                return;
            }
            NSMutableArray *moviesArray = [NSMutableArray new];
            for(NSDictionary *movieDictionary in jsonTopLevelDictionary[@"results"]) {
                AJWMovie *movie = [[AJWMovie alloc] initWithDictionary:movieDictionary];
                [moviesArray addObject:movie];
            }
            completion(moviesArray);
        }
    }] resume];
}

-(void)fetchPosterForMovie:(AJWMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    // build url
    NSLog(@"%@", movie.posterPath);
    NSURL *baseUrl = [NSURL URLWithString:baseImageUrl];
    if ([movie.posterPath isKindOfClass:[NSNull class]]) {
        completion(nil);
        return;
    }
    NSURL *fullUrl = [baseUrl URLByAppendingPathComponent:movie.posterPath];
    
    NSLog(@"%@", [fullUrl absoluteString]);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:fullUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        UIImage *movieImage = [UIImage imageWithData:data];
        completion(movieImage);
    }] resume];
}
@end
