//
//  Player.m
//  api-example
//
//  Created by Mark Bryan on 12/20/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import "Player.h"

@implementation Player

- (NSString*)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
