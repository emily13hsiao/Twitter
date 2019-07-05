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
    
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];

}

- (void)setTweet:(Tweet *)tweet {
    
    _tweet = tweet;
    
    self.usernameLabel.text = tweet.user.screenName;
    self.nameLabel.text = tweet.user.name;
    self.timestampLabel.text = tweet.createdAtString;
    self.tweetTextLabel.text = tweet.text;
    
    self.likeButton.selected = tweet.favorited;
    self.retweetButton.selected = tweet.retweeted;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    
    if ([sender isSelected]) {
        [sender setSelected:NO];
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        //Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }else {
        [sender setSelected:YES];
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
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
    [self refreshCell:self.tweet];
    
    
}
- (IBAction)didTapRetweet:(id)sender {
    
    if ([sender isSelected]) {
        [sender setSelected:NO];
        self.tweet.retweetCount -= 1;
        self.tweet.retweeted = NO;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeting the following Tweet: %@", tweet.text);
            }
        }];
    }else {
        [sender setSelected:YES];
        self.tweet.retweetCount += 1;
        self.tweet.retweeted = YES;
        
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
    
    //Update cell UI
    [self refreshCell:self.tweet];
    
    
}

- (void)refreshCell:(Tweet *)tweet {
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", tweet.favoriteCount] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", tweet.favoriteCount] forState:UIControlStateSelected];
    
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", tweet.retweetCount] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", tweet.retweetCount] forState:UIControlStateSelected];
}

@end
