//
//  pceAppDelegate.h
//  pce
//
//  Created by terrence pietrondi on 11/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pceViewController;

@interface pceAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    pceViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet pceViewController *viewController;

@end

