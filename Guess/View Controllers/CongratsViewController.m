//
//  CongratsViewController.m
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#import "CongratsViewController.h"

@interface CongratsViewController ()

@end

@implementation CongratsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)restartButtonTapped:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
