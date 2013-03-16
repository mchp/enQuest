//
//  Turtle.h
//  Risotto
//
//  Created by Leo Hsu on 07/23/10.
//  Copyright 2010 Ting Chen Leo Hsu. All rights reserved.
//

@interface Turtle : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSInvocationOperation *operationParsing;
@property (nonatomic, weak) NSThread *callThread;

- (void)doWork;
- (void)synchronouslyDoWork;
- (NSURLRequest *)generateRequest;
- (void)parseData;
- (NSString*)CSRFToken;
- (void)finishUp;
- (void)handleErrorOnMainThread:(NSError*)error;
- (void)handleError:(NSError*)error;

- (BOOL)isLoading;
- (void)stopLoading;

@end
