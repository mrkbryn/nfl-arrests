//
//  PlayerTableViewCell.h
//  api-example
//
//  Created by Mark Bryan on 12/21/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrestCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;


@end
