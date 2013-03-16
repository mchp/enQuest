//
//  SettingsViewController.m
//  enQuest
//
//  Created by Leo on 03/14/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginManager.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize loginStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateLoginField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoginField) name:LoginNotification object:nil];
}

- (void)updateLoginField
{
    LoginManager *manager = [LoginManager sharedManager];
    if (manager.status == LoggedIn) {
        self.loginStatus.text = [NSString stringWithFormat:@"Logged in as %@.", manager.username];
    } else {
        self.loginStatus.text = nil;
    }
}

- (IBAction)logout:(id)sender
{
    [[LoginManager sharedManager] logout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
