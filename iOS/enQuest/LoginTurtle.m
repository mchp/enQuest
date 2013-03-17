//
//  SearchingTurtle.m
//  Risotto
//
//  Created by Leo Hsu on 07/07/10.
//  Copyright 2010 Ting Chen Leo Hsu. All rights reserved.
//

#import "LoginTurtle.h"
#import "LoginTurtleDelegate.h"
#import "CSRFTurtle.h"
#import "CSRFTurtleDelegate.h"


@implementation LoginTurtle

@synthesize success;
@synthesize username;
@synthesize password;
@synthesize token;
@synthesize delegate;

- (id)init {
    return [self initWithUsername:nil password:nil];
}

- (id)initWithUsername:(NSString *)u password:(NSString *)p
{
    if (self = [super init]) {
        success = NO;
		username = u;
        password = p;
        delegate = nil;
	}
	return self;
}

- (void)login {
    if (self.isLoading) {
        [self stopLoading];
    }
    
    CSRFTurtle *t = [[CSRFTurtle alloc] init];
    t.delegate = self;
    [t getToken];
}

- (void)CSRFTurtle:(CSRFTurtle *)turtle didGetToken:(NSString *)t
{
    token = t;
    [self doWork];
}

- (void)CSRFTurtleDidFailGetToken:(CSRFTurtle *)turtle withError:(NSError *)error
{
    [self handleError:error];
}

- (NSURLRequest *)generateRequest {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/login/", EQServerDomain]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:StandardConnectionTimeoutPeriod];
    [request setHTTPMethod:@"POST"];
    [request setValue:token forHTTPHeaderField:@"X-CSRFToken"];
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@", self.username, self.password];
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

- (void)parseData
{
    NSError *e;
    NSDictionary *dataDict = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:&e];
    if (e) {
        [self handleErrorOnMainThread:e];
    }
    
    NSString *successStr = [dataDict objectForKey:@"login_success"];
    success = [successStr isEqualToString:@"True"];
}

- (void)finishUp {
    if (success) {
        if ([self.delegate respondsToSelector:@selector(loginTurtleDidFinishLogin:)])
            [self.delegate loginTurtleDidFinishLogin:self];
    }
    else
    {
        /** no descriptive error yet **/
        if ([self.delegate respondsToSelector:@selector(loginTurtleDidFailLogin:withError:)])
            [self.delegate loginTurtleDidFailLogin:self withError:nil];
    }
}

- (void)handleError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(loginTurtleDidFailLogin:withError:)])
        [self.delegate loginTurtleDidFailLogin:self withError:error];
}

@end
