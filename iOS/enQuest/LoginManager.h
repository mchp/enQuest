//
//  LoginManager.h
//  enQuest
//
//  Created by Leo on 03/14/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginTurtleDelegate.h"
#import "LogoutTurtleDelegate.h"

typedef enum {
	LoggedIn,
    LoggingIn,
    LoggedOut,
    LoggingOut
} LoginStatus;

@protocol LoginManagerDelegate;

@interface LoginManager : NSObject  <LoginTurtleDelegate, LogoutTurtleDelegate, NSURLConnectionDataDelegate>


@property LoginStatus status;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, weak) id<LoginManagerDelegate> delegate;

+ (LoginManager *)sharedManager;
- (void)loginWithUsername:(NSString*)username password:(NSString*)password;
- (void)logout;

@end
