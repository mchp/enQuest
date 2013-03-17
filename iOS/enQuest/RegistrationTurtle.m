//
//  RegistrationTurtle.m
//  enQuest
//
//  Created by Leo on 03/14/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "RegistrationTurtle.h"
#import "RegistrationTurtleDelegate.h"
#import "CSRFTurtle.h"
#import "CSRFTurtleDelegate.h"

@implementation RegistrationTurtle

@synthesize success;
@synthesize username;
@synthesize password;
@synthesize email;
@synthesize token;
@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        success = NO;
    }
    return self; 
}

- (void)registerWithUsername:(NSString *)u password:(NSString *)p email:(NSString *)e
{
    self.username = u;
    self.password = p;
    self.email = e;
    
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/register/", EQServerDomain]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:StandardConnectionTimeoutPeriod];
    [request setHTTPMethod:@"POST"];
    [request setValue:token forHTTPHeaderField:@"X-CSRFToken"];
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@&email=%@", self.username, self.password, self.email];
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

- (void)parseData
{
    NSError *e;
    NSDictionary *dataDict = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:&e];
    if (!dataDict) {
        [self handleErrorOnMainThread:e];
    }
    
    NSString *successStr = [dataDict objectForKey:@"success"];
    if ([successStr isEqualToString:@"True"]) {
        success = YES;
    } else {
        NSString *errorStr = [dataDict objectForKey:@"error"];
        NSDictionary *errDict = [NSDictionary dictionaryWithObjectsAndKeys: errorStr,NSLocalizedDescriptionKey, nil];
        NSError *error = [[NSError alloc] initWithDomain:@"EQDomain" code:0 userInfo:errDict];
        [self handleErrorOnMainThread:error];
    }
}

- (void)handleError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(registrationTurtleDidFailRegister:withError:)])
        [self.delegate registrationTurtleDidFailRegister:self withError:error];
}

- (void)finishUp {
    if (success) {
        if ([self.delegate respondsToSelector:@selector(registrationTurtleDidFinishRegister:)])
            [self.delegate registrationTurtleDidFinishRegister:self];
    }
}

@end
