//
//  AppDelegate.h
//  DAE Example
//
//  Created by Cedric Larrat on 03.08.17.
//  Copyright © 2017 Deep Art Effects GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

