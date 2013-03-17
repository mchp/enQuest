//
//  Turtle.m
//  Risotto
//
//  Created by Leo Hsu on 07/23/10.
//  Copyright 2010 Ting Chen Leo Hsu. All rights reserved.
//

#import "Turtle.h"
#import "MasterQueueManager.h"


@implementation Turtle

@synthesize userInfo;
@synthesize connection;
@synthesize data;
@synthesize operationParsing;
@synthesize callThread;

- (id)init {
	if (self = [super init]) {
		userInfo = nil;
		connection = nil;
		data = nil;
		operationParsing = nil;
		callThread = nil;
	}
	return self;
}

- (void)doWork {
	callThread = [NSThread currentThread];
	NSURLRequest *request = [self generateRequest];
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	NSAssert(self.connection, @"Failed to create URL Connection");
}

- (void)synchronouslyDoWork {
	NSURLRequest *request = [self generateRequest];
	self.data = [NSMutableData data];
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:NULL];
	[self.data appendData:d];
	[self parseData];
    [self finishUp];
}

- (NSURLRequest *)generateRequest {
	return nil;
}

- (void)parseDataAndFinish
{
    [self parseData];
    /** only continue if no error **/
    
    [self performSelectorOnMainThread:@selector(finishUp) withObject:nil waitUntilDone:NO];
}

- (void)parseData {
}

- (void)finishUp
{
}

- (void)handleErrorOnMainThread:(NSError *)error
{
    [self performSelectorOnMainThread:@selector(handleError:) withObject:error waitUntilDone:NO];
}

- (void)handleError:(NSError *)error
{
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate  methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"**IN** connection:didFailWithError:\n\n%@", error.userInfo);
    [self handleError:error];
	self.connection = nil;
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate  methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
	[self.data appendData:d];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	self.connection = nil;	
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(parseDataAndFinish) object:nil];
	[[MasterQueueManager sharedQueueManager].mainQueue addOperation:op];
	self.operationParsing = op;
}

#pragma mark -
#pragma mark loading methods

- (BOOL)isLoading {
	if (self.connection)
		return YES;
	else
		return NO;
}

- (void)stopLoading {
	[self.connection cancel];
}

@end
