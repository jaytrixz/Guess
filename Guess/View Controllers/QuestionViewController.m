//
//  QuestionViewController.m
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#import "QuestionViewController.h"

#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface QuestionViewController ()
{
    NSArray *_hintsArray;
    NSUserDefaults *_defaults;
    
    UIAlertView *_alertView;
}

@end

@implementation QuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _defaults                       = [NSUserDefaults standardUserDefaults];
    _hintsArray                     = kHintsArray;
    
    self.hintLabel.text             = kEmptyText;
    self.pictureImageView.image     = kSpongebobImage;
    
    // Tap gesture
    UITapGestureRecognizer *_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:_tapGesture];
    
    // hint button
    NSURL *_buttonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep"
                                                                               ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)_buttonURL, &buttonSound);
    
    // correct button
    NSURL *_correctButtonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"correct"
                                                                                      ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)_correctButtonURL, &correctSound);
    
    // exit button
    NSURL *_exitButtonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"exit"
                                                                                   ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)_exitButtonURL, &exitButtonSound);
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

#pragma mark - Alert view methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AudioServicesPlaySystemSound(buttonSound);
    
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            [SVProgressHUD showWithStatus:kLoadingText];
            
            [self getReferenceCode];
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark - Custom methods

- (void)checkAnswer
{
    if ([self.answerTextField.text isEqualToString:kEmptyText]) {
        _alertView = [[UIAlertView alloc] initWithTitle:kSorry
                                                message:kBlankAnswerMessage
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:kOK, nil];
        [_alertView show];
    } else {
        NSString *_answerString = [self.answerTextField.text lowercaseString];
        
        if ([_answerString isEqualToString:@"spongebob"] &&
            self.scoreImageView.image == kEmptyImage) {
            AudioServicesPlaySystemSound(correctSound);
            
            self.hintLabel.text             = kEmptyText;
            self.pictureImageView.image     = kGarfieldImage;
            self.answerTextField.text       = kEmptyText;
            self.scoreImageView.image       = kOneImage;
            
            if (!self.hintButton.enabled) {
                self.hintButton.enabled = YES;
            }
        } else if ([_answerString isEqualToString:@"garfield"] &&
                   self.scoreImageView.image == kOneImage) {
            AudioServicesPlaySystemSound(correctSound);
            
            self.hintLabel.text             = kEmptyText;
            self.pictureImageView.image     = kWoodyImage;
            self.answerTextField.text       = kEmptyText;
            self.scoreImageView.image       = kTwoImage;
            
            if (!self.hintButton.enabled) {
                self.hintButton.enabled = YES;
            }
        } else if ([_answerString isEqualToString:@"woody"] &&
                   self.scoreImageView.image == kTwoImage) {
            AudioServicesPlaySystemSound(correctSound);
            
            self.hintLabel.text             = kEmptyText;
            self.pictureImageView.image     = kAvengersImage;
            self.answerTextField.text       = kEmptyText;
            self.scoreImageView.image       = kThreeImage;
            
            if (!self.hintButton.enabled) {
                self.hintButton.enabled = YES;
            }
        } else if ([_answerString isEqualToString:@"avengers"] &&
                   self.scoreImageView.image == kThreeImage) {
            AudioServicesPlaySystemSound(correctSound);
            
            self.hintLabel.text             = kEmptyText;
            self.pictureImageView.image     = kAvengersImage;
            
            [self performSegueWithIdentifier:@"ShowCongrats"
                                      sender:self];
        } else {
            _alertView = [[UIAlertView alloc] initWithTitle:kSorry
                                                    message:kWrongMessage
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:kOK, nil];
            [_alertView show];
        }
    }
    
}

- (void)displayHintText
{
    if (self.scoreImageView.image == [UIImage imageNamed:@""]) {
        self.hintLabel.text = _hintsArray[0];
    } else if (self.scoreImageView.image == [UIImage imageNamed:@"1.png"]) {
        self.hintLabel.text = _hintsArray[1];
    } else if (self.scoreImageView.image == [UIImage imageNamed:@"2.png"]) {
        self.hintLabel.text = _hintsArray[2];
    } else if (self.scoreImageView.image == [UIImage imageNamed:@"3.png"]) {
        self.hintLabel.text = _hintsArray[3];
    }
    
    self.hintButton.enabled = NO;
}

- (void)dismissKeyboard
{
    [self.answerTextField resignFirstResponder];
}

- (void)getReferenceCode
{
    NSURL *_referenceCodeURL = [NSURL URLWithString:kReferenceCodeURL];
    NSURLRequest *_referenceCodeRequest = [NSURLRequest requestWithURL:_referenceCodeURL];
    AFHTTPRequestOperation *_referenceCodeOperation = [[AFHTTPRequestOperation alloc] initWithRequest:_referenceCodeRequest];
    _referenceCodeOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [_referenceCodeOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Reference code JSON response: %@", responseObject);
        
        NSString *_referenceString = [responseObject objectForKey:@"reference"];
        
//        NSLog(@"Reference: %llu", [_referenceString longLongValue]);
//        NSLog(@"Plus one: %llu", [_referenceString longLongValue] + 1);
        
        _referenceString = [NSString stringWithFormat:@"%llu", [_referenceString longLongValue] + 1];
        
        [_defaults setObject:_referenceString forKey:@"reference"];
        [_defaults synchronize];
        
        [self sendToChargingAPI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [SVProgressHUD dismiss];
        
        _alertView = [[UIAlertView alloc] initWithTitle:kSorry
                                                message:[error localizedDescription]
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:kOK, nil];
        [_alertView show];
    }];
    [[NSOperationQueue mainQueue] addOperation:_referenceCodeOperation];
}

- (void)sendToChargingAPI
{
    NSString *_tokenString = [_defaults objectForKey:@"token"];
//    NSLog(@"Token: %@", _tokenString);
    NSString *_userIDString = [_defaults objectForKey:@"number"];
//    NSLog(@"Number: %@", _userIDString);
    NSString *_referenceString = [_defaults objectForKey:@"reference"];
//    NSLog(@"Reference: %@", _referenceString);
    
    AFHTTPRequestOperationManager *_chargingManager = [AFHTTPRequestOperationManager manager];
    [_chargingManager POST:kChargingURL parameters:kChargingParameterDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Charging API JSON response: %@", responseObject);
        
        [self incrementReference];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [SVProgressHUD dismiss];
        
        _alertView = [[UIAlertView alloc] initWithTitle:kSorry
                                                message:[error localizedDescription]
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:kOK, nil];
        [_alertView show];
    }];
}

- (void)incrementReference
{
    AFHTTPRequestOperationManager *_chargingManager = [AFHTTPRequestOperationManager manager];
    [_chargingManager POST:kIncrementReferenceURL parameters:kIncrementParameterDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Increment reference JSON response: %@", responseObject);
        
        [SVProgressHUD dismiss];
        
        [self displayHintText];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [SVProgressHUD dismiss];
        
        _alertView = [[UIAlertView alloc] initWithTitle:kSorry
                                                message:[error localizedDescription]
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:kOK, nil];
        [_alertView show];
    }];
}

#pragma mark - Button tapped methods

- (IBAction)submitButtonTapped:(id)sender
{
    AudioServicesPlaySystemSound(buttonSound);
    
    [self.answerTextField resignFirstResponder];
    
    [self checkAnswer];
}

- (IBAction)exitButtonTapped:(id)sender
{
    AudioServicesPlaySystemSound(exitButtonSound);
    
    _alertView = [[UIAlertView alloc] initWithTitle:kQuitting
                                            message:kAreYouSure
                                           delegate:self
                                  cancelButtonTitle:kNo
                                  otherButtonTitles:kYes, nil];
    _alertView.tag = 2;
    [_alertView show];
}

- (IBAction)hintButtonTapped:(id)sender
{
    AudioServicesPlaySystemSound(buttonSound);
    
    _alertView = [[UIAlertView alloc] initWithTitle:kNeedHelp
                                            message:kHintMessage
                                           delegate:self
                                  cancelButtonTitle:kNo
                                  otherButtonTitles:kYes, nil];
    _alertView.tag = 1;
    [_alertView show];
}

@end
