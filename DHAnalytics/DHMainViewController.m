//
//  DHMainViewController.m
//  DHAnalytics
//
//  Created by Tim Shi on 10/19/12.
//  Copyright (c) 2012 Tim Shi. All rights reserved.
//

#import "DHMainViewController.h"

#import "InstagramAuthenticatorView.h"

@interface DHMainViewController () <PFLogInViewControllerDelegate, InstagramAuthDelegate>

@end

@implementation DHMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if (![PFUser currentUser]) {
        PFLogInViewController *loginVC = [[PFLogInViewController alloc] init];
        loginVC.delegate = self;
        loginVC.fields = PFLogInFieldsUsernameAndPassword
                                | PFLogInFieldsLogInButton
                                | PFLogInFieldsSignUpButton
                                | PFLogInFieldsPasswordForgotten
                                | PFLogInFieldsDismissButton
                                | PFLogInFieldsFacebook
                                | PFLogInFieldsTwitter;
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    } else if (![[PFUser currentUser] objectForKey:@"instagram"]) {
        InstagramAuthController *igVC = [[InstagramAuthController alloc] init];
        igVC.authDelegate = self;
        [self.navigationController presentViewController:igVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PFLoginViewControllerDelegate Methods

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - InstagramAuthDelegate Methods

- (void)didAuth:(NSString *)token {
    [[PFUser currentUser] setObject:token forKey:@"instagram"];
    [[PFUser currentUser] saveInBackground];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



@end
