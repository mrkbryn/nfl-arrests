//
//  Crime.h
//  api-example
//
//  Created by Mark Bryan on 12/20/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import <Foundation/Foundation.h>

/* A crime object with a type, description, and date */
@interface Arrest : NSObject

@property (nonatomic) NSDate* date;
@property (nonatomic) NSString* category; // also crime type
@property (nonatomic) NSString* encounter;
@property (nonatomic) NSString* arrestDescription;
@property (nonatomic) NSString* outcome;
@property (nonatomic) NSString* team;

@end
