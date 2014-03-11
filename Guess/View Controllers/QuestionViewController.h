//
//  QuestionViewController.h
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController <UIAlertViewDelegate>
{
    SystemSoundID buttonSound;
    SystemSoundID correctSound;
    SystemSoundID exitButtonSound;
}

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UIButton *hintButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImageView;

- (IBAction)exitButtonTapped:(id)sender;
- (IBAction)hintButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;

@end
