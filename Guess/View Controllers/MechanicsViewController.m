//
//  MechanicsViewController.m
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#import "MechanicsViewController.h"

@interface MechanicsViewController ()

@end

@implementation MechanicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSURL *_skipButtonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep"
                                                                                   ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)_skipButtonURL, &skipButtonSound);
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skipButtonTapped:(id)sender
{
    AudioServicesPlaySystemSound(skipButtonSound);
}

@end
