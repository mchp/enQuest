//
//  SearchingTurtle.m
//  Risotto
//
//  Created by Leo Hsu on 07/07/10.
//  Copyright 2010 Ting Chen Leo Hsu. All rights reserved.
//

#import "LoginTurtle.h"
#import "LoginTurtleDelegate.h"


@implementation LoginTurtle

@synthesize success;
@synthesize username;
@synthesize password;
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
    [self doWork];
}

- (NSURLRequest *)generateRequest {
    NSString *csrf_key = [self CSRFToken];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/login/", EQServerDomain]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:csrf_key forHTTPHeaderField:@"X-CSRFToken"];
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

@end
