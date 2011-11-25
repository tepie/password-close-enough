//
//  KeyboardCharacters.m
//  pce
//
//  Created by terrence pietrondi on 11/25/11.
//  Copyright 2011 pietrondi. All rights reserved.
//

#import "KeyboardCharacters.h"


@implementation KeyboardCharacters
@synthesize boardArrays;

-(id) init {
	if (self = [super init]){
		//[self setBoardArrays : [[[NSMutableArray] alloc] init] ];
		boardArrays = [NSMutableArray arrayWithCapacity:3];
	}
	
	return self;
}

- (void)dealloc {
	[boardArrays release];
    [super dealloc];
}

@end
