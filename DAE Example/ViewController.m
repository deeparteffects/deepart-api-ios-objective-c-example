//
//  ViewController.m
//  DAE Example
//
//  Created by Cedric Larrat on 03.08.17.
//  Copyright © 2017 Deep Art Effects GmbH. All rights reserved.
//

#import "ViewController.h"
#import "DAEDeepArtEffectsClient.h"

@interface ViewController ()

@end

static NSString *accessKey = @"--INSERT YOUR ACCESS KEY--";
static NSString *secretKey = @"--INSERT YOUR SECRET KEY--";
static NSString *apiKey = @"--INSERT YOUR API KEY--";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AWSStaticCredentialsProvider *creds = [[AWSStaticCredentialsProvider alloc] initWithAccessKey:accessKey secretKey:secretKey];
    
    AWSServiceConfiguration *conf = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionEUWest1 credentialsProvider:creds];
    
    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = conf;
    
    self.client = [DAEDeepArtEffectsClient defaultClient];

    self.client.APIKey = apiKey;
    
    [[self.client stylesV2Get] continueWithBlock:^id(AWSTask *task) {
        if (task.error) {
            NSLog(@"Error: %@", task.error);
            return nil;
        }
        if (task.result) {
            DAEStyles *output = task.result;
            self.styles = output.styles;
            NSLog(@"Styles fetched: %lu", self.styles.count);
        }
        return nil;
    }];
    
}

- (IBAction)createArtClicked:(id)sender {
    
    if(self.timerIsRunning) {
        return;
    }
    
    self.timerIsRunning = true;
    
    NSString *imageData = [UIImagePNGRepresentation(self.photoImageView.image) base64EncodedStringWithOptions: NSDataBase64EncodingEndLineWithLineFeed];
    
    int randomStyleIndex = (int) arc4random_uniform((UInt32) self.styles.count);

    DAEStyle *style = self.styles[randomStyleIndex];
    
    DAEUploadRequest *uploadRequest = [DAEUploadRequest alloc];
    uploadRequest.styleId = style._id;
    uploadRequest.imageBase64Encoded = imageData;
    
    NSLog(@"Upload image using style %@", style._id);

    [[self.client uploadPost:uploadRequest] continueWithBlock:^id(AWSTask *task) {
        if (task.error) {
            NSLog(@"Error: %@", task.error);
            return nil;
        }
        if (task.result) {
            DAEUploadResponse *output = task.result;
            
            NSLog(@"Upload finished");
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5
                                                              target:self
                                                            selector:@selector(checkSubmissionStatus:)
                                                            userInfo:output.submissionId
                                                             repeats:YES];
            });
        }
        return nil;
    }];
}

- (void) checkSubmissionStatus:(NSTimer *)timer {
    NSLog(@"Checking for a result");
    
    [[self.client resultGet:self.timer.userInfo] continueWithBlock:^id(AWSTask *task) {
        if (task.error) {
            NSLog(@"Error: %@", task.error);
            return nil;
        }
        if (task.result) {
            DAEResult *output = task.result;
            
            if([output.status isEqual: @"finished"]) {
                NSLog(@"Artwork is ready");
                self.timerIsRunning = false;
                [self.timer invalidate];
                
                NSURL *url = [NSURL URLWithString:output.url];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [[UIImage alloc] initWithData:data];
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    self.photoImageView.image = image;
                });
            }
        }
        return nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
