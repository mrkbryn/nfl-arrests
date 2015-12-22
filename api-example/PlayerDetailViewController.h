//
//  PlayerDetailViewController.h
//  api-example
//
//  Created by Mark Bryan on 12/22/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "Arrest.h"
#import "ArrestTableViewCell.h"

@interface PlayerDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *numArrestsLabel;
@property (nonatomic) Player *p;
@property (nonatomic) NSArray *arrests;
@property (weak, nonatomic) IBOutlet UITableView *arrestsTableView;

- (void)populateArrests;
- (IBAction)backPressed:(id)sender;

@end
