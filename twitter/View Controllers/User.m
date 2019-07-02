//
//  User.m
//  twitter
//
//  Created by emily13hsiao on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        
        /**
         NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
         NSString *posterURLString = movie[@"poster_path"];
         NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
         NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        **/
        
        self.profilePictureURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        
    }
    return self;
}

@end
