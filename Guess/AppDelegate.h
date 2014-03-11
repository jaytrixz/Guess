//
//  AppDelegate.h
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate>
{
    AVAudioPlayer *backgroundMusic;
}

@property (strong, nonatomic) UIWindow *window;

@end
