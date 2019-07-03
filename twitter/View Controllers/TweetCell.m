//
//  TweetCell.m
//  
//
//  Created by emily13hsiao on 7/1/19.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    //Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    //Update cell UI
    [sender setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    /**if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        [sender setSelected:NO];
     **/
    /** }else {
        [sender setImage:favor-icon forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
    **/
    //Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}
- (IBAction)didTapRetweet:(id)sender {
    //Update local tweet model
    self.tweet.retweeted = YES;
    self.tweet.favoriteCount += 1;
    
    //Update cell UI
    [sender setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    
    //Send a POST request to the POST retweets/create endpoint
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeting the following Tweet: %@", tweet.text);
        }
    }];
}

@end
