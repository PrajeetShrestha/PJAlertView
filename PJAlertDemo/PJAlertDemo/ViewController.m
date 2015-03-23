//
//  ViewController.m
//  PJAlertDemo
//
//  Created by Prajeet Shrestha on 3/23/15.
//  Copyright (c) 2015 Prajeet Shrestha. All rights reserved.
//

#import "ViewController.h"
#import "PJAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showPJAlert:(id)sender {
    PJAlertView *pjAlert = [[PJAlertView alloc]initWithTitle:@"PJAlertView" message:@"This is really cool" delegate:nil cancelButtonTitle:@"Ok" okButtonTitle:nil];
    
    [pjAlert show];
}

@end
