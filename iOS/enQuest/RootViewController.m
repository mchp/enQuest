//
//  RootViewController.m
//  enQuest
//
//  Created by Leo on 03/15/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "RootViewController.h"
#import "LoginManager.h"
#import "LoginViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissWaitScreen) name:LoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayLoginScreen) name:LogoutNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    LoginStatus status = [[LoginManager sharedManager] status];
    if (status == LoggedOut) {
        [self displayLoginScreen];
    }
    else if (status == LoggingIn) {
        NSLog(@"...displayWaitScreen");
        [self performSegueWithIdentifier:@"WaitScreen" sender:self];
    }
}

- (void)displayLoginScreen
{
    NSLog(@"...displayLoginScreen");
    NSAssert([[LoginManager sharedManager] status] == LoggedOut, @"login status inconsistent");
    [self performSegueWithIdentifier:@"LoginScreen" sender:self];
}

- (void)dismissWaitScreen
{
    NSLog(@"...dismissWaitScreen");
    /** make sure this is wait screen **/
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
