//
//  AJWMovie.h
//  MovieDataBaseOBJC
//
//  Created by Austin West on 5/24/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJWMovie : NSObject

@property (nonatomic,  copy, readonly) NSString *movieTitle;
@property (nonatomic, copy, readonly) NSString *movieDescription;
@property (nonatomic, copy, readonly) NSString *posterPath;
@property (nonatomic, readonly, nullable) NSNumber *votes;
@property (nonatomic, copy, readonly, nullable) NSNumber *rating;

-(instancetype) initWithTitle:(NSString *)title movieDescription:(NSString *)movieDescription posterPath:(NSString *)posterPath votes:(NSNumber *)votes rating:(NSNumber *)rating;

@end

@interface AJWMovie (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
