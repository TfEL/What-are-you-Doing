//
//  administrationViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 18/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "administrationViewController.h"

@interface administrationViewController ()

@end

@implementation administrationViewController

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://wrud.tfel.edu.au"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
