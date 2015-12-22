//
//  Player.h
//  api-example
//
//  Created by Mark Bryan on 12/20/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import <Foundation/Foundation.h>

/* A player object with a first/last name, an array of crimes */
@interface Player : NSObject

@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSArray* arrests;
@property (nonatomic) int arrestCount;
@property (nonatomic, copy) NSString* position;

//- (id)initWithJSON:(NSDictionary*)json;

@end
