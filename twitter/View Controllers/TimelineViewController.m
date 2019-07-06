//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *tweetArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchTweets];
}

- (void)fetchTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweetArray = [[NSArray alloc] initWithArray:tweets];
            
            //Reload tableview
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
    if ([segue.identifier isEqualToString:@"compose"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    } else {
        UINavigationController *navigationController = [segue destinationViewController];
        ProfileViewController *profileController = (ProfileViewController*)navigationController.topViewController;
        
        TweetCell *tappedCell = sender;
        //NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        User *user = tappedCell.tweet.user;
        
        profileController.user = user;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweetArray[indexPath.row];

    [cell.profilePictureView setImageWithURL:tweet.user.profilePictureURL];
    
    [cell.likeButton setTitle:[NSString stringWithFormat:@"%i", tweet.favoriteCount] forState:UIControlStateNormal];
    [cell.likeButton setTitle:[NSString stringWithFormat:@"%i", tweet.favoriteCount] forState:UIControlStateSelected];
    
    [cell.retweetButton setTitle:[NSString stringWithFormat:@"%i", tweet.retweetCount] forState:UIControlStateNormal];
    [cell.retweetButton setTitle:[NSString stringWithFormat:@"%i", tweet.retweetCount] forState:UIControlStateSelected];
    
    cell.tweet = tweet;
    return cell;
}



- (void)didTweet:(nonnull Tweet *)tweet {
    //After tweeting, reload tweets. 
    [self fetchTweets];
}

- (IBAction)didTapLogout:(id)sender {
    NSLog(@"log out");
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}




@end
