//
//  AJWMovie.m
//  MovieDataBaseOBJC
//
//  Created by Austin West on 5/24/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import "AJWMovie.h"

@implementation AJWMovie

-(instancetype)initWithTitle:(NSString *)title movieDescription:(NSString *)movieDescription posterPath:(NSString *)posterPath votes:(NSNumber *)votes rating:(NSNumber *)rating
{
    self = [super init];
    if (self) {
        _movieTitle = title;
        _rating = rating;
        _votes = votes;
        _movieDescription = movieDescription;
        _posterPath = posterPath;
    }
    return self;
    
}
@end

@implementation AJWMovie (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *movieTitle = dictionary[@"title"];
    NSString *movieDescription = dictionary[@"overview"];
    NSNumber *votes = dictionary[@"vote_count"];
    NSNumber *rating = dictionary[@"vote_average"];
    NSString *posterPath = dictionary[@"poster_path"];
    
    return [self initWithTitle:movieTitle movieDescription:movieDescription posterPath:posterPath votes:votes rating:rating];
}

@end
