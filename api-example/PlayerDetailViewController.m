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

@synthesize p;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateArrests {
    // Call API
    NSString *baseURLString = @"http://nflarrest.com/api/v1/player/arrests/";
    // change whitespace in name to %20's for api call
    NSString *nameEndpoint = [p.firstName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *playerSearchURLString = [NSString stringWithFormat:@"%@%@", baseURLString, nameEndpoint];
    NSURL *searchURL = [NSURL URLWithString:playerSearchURLString];
    
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
                // assign p's arrest array
                p.arrests = arrestArray;
                
                // handle JSON
                
                for (int i = 0; i < arrestArray.count; i++) {
                    NSDictionary *dict = [arrestArray objectAtIndex:i];
                    
                    NSString *team = [dict objectForKey:@"Team"];
                    NSString *dateString = [dict objectForKey:@"Date"];
                    NSString *category = [dict objectForKey:@"Category"];
                    NSString *arrestDescription = [dict objectForKey:@"Description"];
                    NSString *arrestOutcome = [dict objectForKey:@"Outcome"];
                    
                    NSLog(@"Arrest %i while on %@: %@, %@, \nDescription: %@\nOutcome: %@", i + 1, team, category, dateString, arrestDescription, arrestOutcome);
                    
                }
                
            }
            
        }
    }];
    [playerArrestInfoDataTask resume];
}

- (IBAction)backPressed:(id)sender {
    // pop off this view controller
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
