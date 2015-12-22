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
@property (nonatomic, copy) NSString* position;
// arrests list is null until detail view allocates by making API call
@property (nonatomic, copy) NSArray* arrests;

// placeholder arrestCount value to fill master table view
@property (nonatomic) int arrestCount;

//- (id)initWithJSON:(NSDictionary*)json;

- (NSString*)fullName;

@end
