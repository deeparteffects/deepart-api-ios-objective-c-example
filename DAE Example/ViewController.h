//
//  ViewController.h
//  DAE Example
//
//  Created by Cedric Larrat on 03.08.17.
//  Copyright © 2017 Deep Art Effects GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAEDeepArtEffectsClient.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property DAEDeepArtEffectsClient *client;

@property NSArray *styles;

@property NSTimer *timer;

@property Boolean timerIsRunning;

- (IBAction)createArtClicked:(id)sender;

- (void)checkSubmissionStatus:(NSTimer *)timer;

@end

