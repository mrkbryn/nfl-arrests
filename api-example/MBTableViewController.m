//
//  MBTableViewController.m
//  api-example
//
//  Created by Mark Bryan on 12/19/15.
//  Copyright © 2015 Mark Bryan. All rights reserved.
//

#import "MBTableViewController.h"

@interface MBTableViewController ()
{
    NSMutableArray *playerData;
    NSArray *jsonArray;
}

@end

@implementation MBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Table View data
    playerData = [[NSMutableArray alloc] init];
    [self.tableView setDataSource:self];
    
    // Register Nibs
    UINib *playerCellNib = [UINib nibWithNibName:@"PlayerTableViewCell" bundle:nil];
    [self.tableView registerNib:playerCellNib forCellReuseIdentifier:@"playercell"];
    
    // API call
    NSString *urlString = @"http://nflarrest.com/api/v1/player";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // safer for data task
    __weak typeof((self)) weakSelf = self;
    
    NSURLSessionDataTask *getPlayersDataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // check for error
        if (error) {
            // handle error better...
            NSLog(@"%@", error);
        } else {
            NSError *jsonParsingError = nil;
            
            jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            
            if (jsonParsingError) {
                // JSON couldn't be parsed
                NSLog(@"Error parsing json data");
            } else {
                // handle JSON here
                NSLog(@"Handling JSON");
                
                for (int i = 0; i < [jsonArray count]; i++) {
                    NSDictionary *playerDict = [jsonArray objectAtIndex:i];
                    
                    NSString *playerName = [playerDict objectForKey:@"Name"];
                    NSString *playerPosition = [playerDict objectForKey:@"Position"];
                    NSString *arrestCount = [playerDict objectForKey:@"arrest_count"];
                    
                    NSLog(@"Player %i: %@, Position: %@, Arrest Count: %@", i + 1, playerName, playerPosition, arrestCount);
                    
                    Player *p = [[Player alloc] init];
                    // parse name (fname, lname)
                    p.firstName = playerName;
                    p.position = playerPosition;
                    p.arrestCount = arrestCount.intValue;
                    
                    [playerData addObject:p];
                    
                }
                
                // update UI in main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView setNeedsDisplay];
                });
            }
        }
    }];
    [getPlayersDataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return playerData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerTableViewCell *cell = (PlayerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"playercell" forIndexPath:indexPath];
    
    Player *p = [playerData objectAtIndex:[indexPath row]];
    
    cell.playerNameLabel.text = p.firstName;
    cell.arrestCountLabel.text = [NSString stringWithFormat:@"%i", p.arrestCount];
    cell.positionLabel.text = p.position;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Player *player = [playerData objectAtIndex:[indexPath row]];
    NSLog(@"Selected player %@", player.firstName);
    
    
    
    PlayerDetailViewController *detailVC = [[PlayerDetailViewController alloc] initWithNibName:@"PlayerDetailViewController" bundle:nil];
    [self presentViewController:detailVC animated:YES completion:nil];
    
    // would be good to start API call after assigning player variable...
    detailVC.p = player;
    [detailVC populateArrests];
    detailVC.playerNameLabel.text = player.firstName;
    detailVC.positionLabel.text = player.position;
    detailVC.numArrestsLabel.text = [NSString stringWithFormat:@"%i Arrests", player.arrestCount];
    
}

@end
