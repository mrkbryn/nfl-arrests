//
//  ArrestTableViewCell.m
//  api-example
//
//  Created by Mark Bryan on 12/22/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import "ArrestTableViewCell.h"

@implementation ArrestTableViewCell

@synthesize categoryLabel, dateLabel, descriptionBox, teamLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
