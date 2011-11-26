//
//  pceViewController.m
//  pce
//
//  Created by terrence pietrondi on 11/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "pceViewController.h"
#import "KeyboardCharacters.h"

@implementation pceViewController
@synthesize userTextField;
@synthesize passwordTextField;
@synthesize resultsLabel;
@synthesize passwordStorage;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.passwordStorage = [[NSMutableDictionary alloc] init];
    [super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[userTextField release];
	[passwordTextField release];
	[resultsLabel release];	
	[passwordStorage release];
    [super dealloc];
}

- (IBAction) storeMockLogin{
	NSLog(@"user text field: %@",  self.userTextField.text);
	NSLog(@"password text field: %@",  self.passwordTextField.text);
	[passwordStorage setObject: self.passwordTextField.text forKey: self.userTextField.text];
	NSLog(@"map value for key: %@",  [self.passwordStorage objectForKey: self.userTextField.text] );
}

- (IBAction) checkMockLoginCloseEnough{
	KeyboardCharacters *characters = [[KeyboardCharacters alloc] init];
}
	

@end
