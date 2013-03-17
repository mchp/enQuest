//
//  LogoutTurtle.m
//  enQuest
//
//  Created by Leo on 03/15/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "LogoutTurtle.h"
#import "LogoutTurtleDelegate.h"

@implementation LogoutTurtle

- (void)logout {
    if (self.isLoading) {
        [self stopLoading];
    }
    [self doWork];
}

- (NSURLRequest *)generateRequest {
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/logout/", EQServerDomain]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:StandardConnectionTimeoutPeriod];
}

- (void)finishUp {
    if ([self.delegate respondsToSelector:@selector(logoutTurtleDidFinishLogout:)])
        [self.delegate logoutTurtleDidFinishLogout:self];
}

- (void)handleError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(logoutTurtleDidFailLogout:withError:)]) {
        [self.delegate logoutTurtleDidFailLogout:self withError:error];
    }
}

@end
