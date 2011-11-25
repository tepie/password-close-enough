//
//  pceViewController.h
//  pce
//
//  Created by terrence pietrondi on 11/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pceViewController : UIViewController {
	UITextField *userTextField;
	UITextField *passwordTextField;
	UILabel *resultsLabel;	
	NSMutableDictionary *passwordStorage;

}

@property (nonatomic,retain) IBOutlet UITextField *userTextField;
@property (nonatomic,retain) IBOutlet UITextField *passwordTextField;
@property (nonatomic,retain) IBOutlet UILabel *resultsLabel;

@property (nonatomic,retain) IBOutlet NSMutableDictionary *passwordStorage;

- (IBAction) storeMockLogin;
- (IBAction) checkMockLoginCloseEnough;



@end

