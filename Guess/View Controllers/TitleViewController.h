//
//  TitleViewController.h
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleViewController : UIViewController
{
    SystemSoundID backgroundBeat;
    SystemSoundID playButtonSound;
}

- (IBAction)playButtonTapped:(id)sender;

@end
