//
//  CSRFTurtle.m
//  enQuest
//
//  Created by Leo on 03/17/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "CSRFTurtle.h"
#import "CSRFTurtleDelegate.h"

@implementation CSRFTurtle

@synthesize token;
@synthesize delegate;

- (id)init
{
    if (self = [super init]) {
        token = nil;
        delegate = nil;
    }
    return self;
}

- (void)getToken {
    if (self.isLoading) {
        [self stopLoading];
    }
    [self doWork];
}

- (NSURLRequest *)generateRequest
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@users/test/", EQServerDomain]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:StandardConnectionTimeoutPeriod];
    return request;
}

- (void)parseData
{
    // get CSRF token from cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:EQServerDomain]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==\"csrftoken\""];
    NSArray *csrf_cookies = [cookies filteredArrayUsingPredicate:predicate];
    NSHTTPCookie *cookie = [csrf_cookies lastObject];
    token = [cookie value];
}

- (void)finishUp {
    if (token) {
        if ([delegate respondsToSelector:@selector(CSRFTurtle:didGetToken:)]) {
            [delegate CSRFTurtle:self didGetToken:token];
        }
        delegate = nil;
    }
    else
    {
        /** need error content **/
        [self handleError:nil];
    }
}

- (void)handleError:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(CSRFTurtleDidFailGetToken:withError:)])
        [delegate CSRFTurtleDidFailGetToken:self withError:error];
}

@end
