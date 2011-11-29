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
	resultsLabel.text = @"Username and password have been stored.";
	
}

- (IBAction) checkMockLoginCloseEnough{
	NSString* storedPasswordForUser = [self.passwordStorage objectForKey: self.userTextField.text];
	NSLog(@"password for user: %@",  storedPasswordForUser);
	if(storedPasswordForUser != nil){
		NSString* closeEnoughPassword = self.passwordTextField.text;
		
		//NSArray *cepArray = [closeEnoughPassword componentsSeparatedByString:@""];
		//NSArray *storedArray = [storedPasswordForUser componentsSeparatedByString:@""];
		KeyboardCharacters *characters = [[KeyboardCharacters alloc] init];
		
		BOOL closeEnough = true;
		int cnt = 0;
		
		NSCharacterSet *letterSet = [NSCharacterSet letterCharacterSet];
		
		while(closeEnough && cnt < [storedPasswordForUser length]){
			NSRange range = {cnt,1};
			NSString *left = [storedPasswordForUser substringWithRange:range];
			//NSUInteger len = 1;
			//NSString* leftStr = [[NSString alloc] initWithCharacters:left length:len];
			NSLog(@"left side compare: %@",  left);
			
			NSString *right = [closeEnoughPassword substringWithRange:range];
			NSLog(@"right side compare: %@",  right);
			
			if([left compare: right] != 0){
			
				BOOL isNotLetterLeft = [[left stringByTrimmingCharactersInSet:letterSet] isEqualToString:@""];
				BOOL isNotLetterRight = [[right stringByTrimmingCharactersInSet:letterSet] isEqualToString:@""];
			
				if(isNotLetterLeft && isNotLetterRight){
					closeEnough = [characters isAround: left: right];
				}
			}
			cnt++;
		}
		
		if(closeEnough){
			resultsLabel.text = @"Password IS close enough!";
		} else {
			resultsLabel.text = @"Password IS NOT close enough!";
		}
		
	} else {
		resultsLabel.text = @"Username not found.";
	}

}
	

@end
