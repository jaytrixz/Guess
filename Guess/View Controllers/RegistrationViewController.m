//
//  RegistrationViewController.m
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#import "RegistrationViewController.h"

#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface RegistrationViewController ()
{
    NSUserDefaults *_defaults;
}

@end

@implementation RegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [SVProgressHUD showWithStatus:kLoadingText];
    
    self.navigationController.navigationBarHidden = NO;
    
    _defaults = [NSUserDefaults standardUserDefaults];
    
    NSURL *_registrationURL = [NSURL URLWithString:kRegistrationURL];
    NSURLRequest *_registrationRequest = [NSURLRequest requestWithURL:_registrationURL];
    AFHTTPRequestOperation *_registrationOperation = [[AFHTTPRequestOperation alloc] initWithRequest:_registrationRequest];
    _registrationOperation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [_registrationOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Response: %@", responseObject);
        
        NSString *_responseString = [[NSString alloc] initWithData:responseObject
                                                          encoding:NSUTF8StringEncoding];
        
        [self.registrationWebView loadHTMLString:_responseString
                                         baseURL:_registrationURL];
        
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:_registrationOperation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
    [self.registrationWebView stopLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web view methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [SVProgressHUD showWithStatus:kLoadingText];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"1");
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [SVProgressHUD dismiss];
    
    NSURL *_requestURL = self.registrationWebView.request.URL;
    NSError *error;
    NSString *_contentsOfURL = [NSString stringWithContentsOfURL:_requestURL
                                                        encoding:NSASCIIStringEncoding
                                                           error:&error];
    
    NSData *_webviewData = [_contentsOfURL dataUsingEncoding:NSUTF8StringEncoding];
    id _JSONObject = [NSJSONSerialization JSONObjectWithData:_webviewData
                                                     options:0
                                                       error:&error];
    
    NSLog(@"JSON: %@", _JSONObject);
    
    if (_JSONObject != nil) {
        if (![[_JSONObject objectForKey:@"error"] isEqualToString:@"Invalid confirmation code"]) {
            [self saveTokenAndNumberToUserDefaultsWithJSON:_JSONObject];
            
            [self performSegueWithIdentifier:@"ShowMechanics"
                                      sender:self];
        } else {
            NSString *_errorMessage = [_JSONObject objectForKey:@"error"];
            UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:kSorry
                                                                 message:_errorMessage
                                                                delegate:self
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:kOK, nil];
            [_alertView show];
            
            [_defaults setObject:kNo
                          forKey:@"isFirstLaunch"];
        }
    } else {
        NSLog(@"nil");
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Registration webview failed to load with error: %@", error);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - Custom methods

- (void)saveTokenAndNumberToUserDefaultsWithJSON:(NSDictionary *)json
{
    NSLog(@"JSON: %@", json);
    NSLog(@"Token: %@", [json objectForKey:@"access_token"]);
    NSLog(@"Number: %@", [json objectForKey:@"subscriber_number"]);
    
    NSString *_token = [json objectForKey:@"access_token"];
    NSString *_number = [json objectForKey:@"subscriber_number"];
    
    [_defaults setValue:_token
                 forKey:@"token"];
    [_defaults setValue:_number
                 forKey:@"number"];
    [_defaults synchronize];

}

@end
