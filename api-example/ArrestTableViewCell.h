//
//  ArrestTableViewCell.h
//  api-example
//
//  Created by Mark Bryan on 12/22/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrestTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;

@end
