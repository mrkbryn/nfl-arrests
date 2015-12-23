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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // arrestsTableView setup
    self.arrestsTableView.delegate = self;
    self.arrestsTableView.dataSource = self;
    [self.arrestsTableView setUserInteractionEnabled:YES];
    
    // Register Nibs
    UINib *arrestNib = [UINib nibWithNibName:@"ArrestTableViewCell" bundle:nil];
    [self.arrestsTableView registerNib:arrestNib forCellReuseIdentifier:@"arrestcell"];
    
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)populateArrests {
    // Call API
    NSString *baseURLString = @"http://nflarrest.com/api/v1/player/arrests/";
    // change whitespace in name to %20's for api call
    NSString *nameEndpoint = [self.p.firstName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *playerSearchURLString = [NSString stringWithFormat:@"%@%@", baseURLString, nameEndpoint];
    NSURL *searchURL = [NSURL URLWithString:playerSearchURLString];
    
    NSLog(@"Connecting to %@", searchURL);
    
    // safer for data task
    __weak typeof((self)) weakSelf = self;
    
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
                    
                    [temp addObject:newArrest];
                    
                }
                
                // Assign instance variable after parsing JSON into Arrest objects
                weakSelf.arrests = [temp copy];
                
            }

            // update UI in main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.arrestsTableView reloadData];
                [self.arrestsTableView setNeedsDisplay];
            });
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
    return self.arrests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArrestTableViewCell *cell = (ArrestTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"arrestcell" forIndexPath:indexPath];
    
    Arrest *a = [self.arrests objectAtIndex:[indexPath row]];
    
    cell.descriptionText.text = [NSString stringWithFormat:@"%@\nOutcome: %@", a.arrestDescription, a.outcome];
    cell.categoryLabel.text = a.category;
    cell.dateLabel.text = a.date;
    cell.teamLabel.text = a.team;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

@end
