//
//  ProfileViewController.m
//  twitter
//
//  Created by emily13hsiao on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Load poster image
    [self.profilePictureView setImageWithURL:self.user.profilePictureURL];
    
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = self.user.screenName;
    self.followersLabel.text = [NSString stringWithFormat:@"Followers: %i", self.user.followerCount];
    self.followingLabel.text = [NSString stringWithFormat:@"Following: %i", self.user.followingCount];
    self.bioLabel.text = self.user.bio;

    /**
    @property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    @property (weak, nonatomic) IBOutlet UILabel *handleLabel;
    @property (weak, nonatomic) IBOutlet UILabel *followersLabel;
    @property (weak, nonatomic) IBOutlet UILabel *followingLabel;
    @property (weak, nonatomic) IBOutlet UILabel *bioLabel;
     **/
    
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
