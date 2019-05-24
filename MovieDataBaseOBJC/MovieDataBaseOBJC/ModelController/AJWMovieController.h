//
//  AJWMovieController.h
//  MovieDataBaseOBJC
//
//  Created by Austin West on 5/24/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJWMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface AJWMovieController : NSObject

//Singleton
+(instancetype) sharedInstance;

-(void) fetchMoviesWithSearch:(NSString *)search completion:(void (^) (NSArray<AJWMovie *> * movies)) completion;
-(void) fetchPosterForMovie:(AJWMovie *)movie completion:(void (^) (UIImage * _Nullable image))completion;

@end

NS_ASSUME_NONNULL_END
