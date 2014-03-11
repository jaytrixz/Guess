//
//  TitleViewController.m
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#import "TitleViewController.h"

@interface TitleViewController ()

@end

@implementation TitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSURL *_playButtonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep"
                                                                                   ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)_playButtonURL, &playButtonSound);
    
    NSURL *_backgroundBeatURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beat"
                                                                                       ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)_backgroundBeatURL, &backgroundBeat);
    
    AudioServicesPlaySystemSound(backgroundBeat);
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

- (IBAction)playButtonTapped:(id)sender
{
    AudioServicesPlaySystemSound(playButtonSound);
    
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    if (![[_defaults objectForKey:@"isFirstLaunch"] isEqualToString:kYes]) {
        [_defaults setObject:kYes
                      forKey:@"isFirstLaunch"];
        
        [self performSegueWithIdentifier:@"ShowRegistration"
                                  sender:self];
    } else {
        [self performSegueWithIdentifier:@"SkipMechanics"
                                  sender:self];
    }
}

@end
