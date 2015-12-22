//
//  PlayerDetailViewController.m
//  api-example
//
//  Created by Mark Bryan on 12/22/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import "PlayerDetailViewController.h"

@interface PlayerDetailViewController ()

@end

@implementation PlayerDetailViewController

@synthesize p, arrests, arrestsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    arrestsTableView.delegate = self;
    arrestsTableView.dataSource = self;
    [arrestsTableView setUserInteractionEnabled:NO];
    
    // Register Nibs
    UINib *arrestNib = [UINib nibWithNibName:@"ArrestTableViewCell" bundle:nil];
    [arrestsTableView registerNib:arrestNib forCellReuseIdentifier:@"arrestcell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)populateArrests {
    // Call API
    NSString *baseURLString = @"http://nflarrest.com/api/v1/player/arrests/";
    // change whitespace in name to %20's for api call
    NSString *nameEndpoint = [p.firstName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *playerSearchURLString = [NSString stringWithFormat:@"%@%@", baseURLString, nameEndpoint];
    NSURL *searchURL = [NSURL URLWithString:playerSearchURLString];
    
    NSLog(@"Connecting to %@", searchURL);
    
    NSURLSessionDataTask *playerArrestInfoDataTask = [[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"Handling JSON from player arrest search");
            
            NSError *jsonParsingError;
            // handle data
            NSArray *arrestArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            
            if (jsonParsingError) {
                NSLog(@"Error while handling player arrest json");
            } else {
                // handle JSON
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < arrestArray.count; i++) {
                    NSDictionary *dict = [arrestArray objectAtIndex:i];
                    
                    NSString *team = [dict objectForKey:@"Team"];
                    NSString *dateString = [dict objectForKey:@"Date"];
                    NSString *category = [dict objectForKey:@"Category"];
                    NSString *arrestDescription = [dict objectForKey:@"Description"];
                    NSString *arrestOutcome = [dict objectForKey:@"Outcome"];
                    
                    NSLog(@"Arrest %i while on %@: %@, %@, \nDescription: %@\nOutcome: %@", i + 1, team, category, dateString, arrestDescription, arrestOutcome);
                    
                    Arrest *newArrest = [[Arrest alloc] init];
                    newArrest.team = team;
                    newArrest.date = dateString;
                    newArrest.category = category;
                    newArrest.arrestDescription = arrestDescription;
                    newArrest.outcome = arrestOutcome;
                    newArrest.type = DUI;
                    
                    [temp addObject:newArrest];
                    
                }
                
                // Assign instance variable after parsing JSON into Arrest objects
                arrests = [temp copy];
                
                [arrestsTableView reloadData];
                [arrestsTableView setNeedsDisplay];
                
            }
            
        }
    }];
    [playerArrestInfoDataTask resume];
}

- (IBAction)backPressed:(id)sender {
    // pop off this view controller
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArrestTableViewCell *cell = (ArrestTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"arrestcell" forIndexPath:indexPath];
    
    Arrest *a = [arrests objectAtIndex:[indexPath row]];
    
    cell.descriptionBox.text = a.arrestDescription;
    cell.categoryLabel.text = a.category;
    cell.dateLabel.text = a.date;
    cell.teamLabel.text = a.team;
    [cell.descriptionBox sizeToFit];
    [cell setNeedsDisplay];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 120;
//}

@end
