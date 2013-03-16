//
//  LoginManager.m
//  enQuest
//
//  Created by Leo on 03/14/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "SYNTHESIZE_GOD.h"

#import "LoginManager.h"
#import "LoginTurtle.h"
#import "LoginManagerDelegate.h"
#import "LogoutTurtle.h"
#import "LogoutTurtleDelegate.h"

@implementation LoginManager

SYNTHESIZE_GOD(LoginManager, sharedManager);

@synthesize status;
@synthesize username;
@synthesize delegate;

- (id)init
{
    if (self = [super init]) {
        status = LoggedOut;
        username = nil;
        delegate = nil;
    }
    return self;
}

#pragma mark loggin in

- (void)loginWithUsername:(NSString*)u password:(NSString*)p
{
    status = LoggingIn;
    LoginTurtle *t = [[LoginTurtle alloc] initWithUsername:u password:p];
    t.delegate = self;
    [t login];
}

- (void)loginTurtleDidFinishLogin:(LoginTurtle *)turtle
{
    self.username = turtle.username;
    status = LoggedIn;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:LoginInformationStoredKey];
    [defaults setObject:turtle.username forKey:StoredUsernameKey];
    [defaults setObject:turtle.password forKey:StoredPasswordKey];
    [defaults synchronize];
    
    NSNotification *note = [NSNotification notificationWithName:LoginNotification object:self];
	[[NSNotificationCenter defaultCenter] postNotification:note];
    
    if ([self.delegate respondsToSelector:@selector(loginDidFinish)]) {
        [self.delegate loginDidFinish];
    }
    delegate = nil;
}

- (void)loginTurtleDidFailLogin:(LogoutTurtle *)turtle withError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(loginDidFail)]) {
        [self.delegate loginDidFail];
    }
    delegate = nil;
}

#pragma mark logging out

- (void)logout
{
    status = LoggingOut;
    LogoutTurtle *t = [[LogoutTurtle alloc] init];
    t.delegate = self;
    [t logout];
}

- (void)logoutTurtleDidFinishLogout:(LogoutTurtle *)turtle
{
    self.username = nil;
    status = LoggedOut;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:LoginInformationStoredKey];
    [defaults setObject:nil forKey:StoredUsernameKey];
    [defaults setObject:nil forKey:StoredPasswordKey];
    [defaults synchronize];
    
    NSNotification *note = [NSNotification notificationWithName:LogoutNotification object:self];
	[[NSNotificationCenter defaultCenter] postNotification:note];
    
    delegate = nil;
}



@end
