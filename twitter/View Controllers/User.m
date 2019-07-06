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
        self.screenName = [NSString stringWithFormat:@"@%@", dictionary[@"screen_name"]];
        self.profilePictureURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.bio = dictionary[@"description"];
        self.followerCount = [dictionary[@"follower_count"]intValue];
        NSLog([NSString stringWithFormat:@"Follower Count: %i", [dictionary[@"follower_count"]intValue]]);
        self.followingCount = [dictionary[@"friends_count"]intValue];
    }
    return self;
}

@end
