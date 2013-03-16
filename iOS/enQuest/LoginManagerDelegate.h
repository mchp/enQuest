//
//  LoginManagerDelegate.h
//  enQuest
//
//  Created by Leo on 03/15/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginManagerDelegate <NSObject>
@optional
- (void)loginDidFinish;
- (void)loginDidFail;

@end
