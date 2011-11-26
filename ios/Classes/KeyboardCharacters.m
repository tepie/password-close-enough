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
		
		boardArrays = [NSMutableArray arrayWithCapacity:3];
		
		NSMutableArray *row1 = [NSMutableArray arrayWithCapacity:10];
		[row1 addObject:  @"q"];
		[row1 addObject:  @"w"];
		[row1 addObject:  @"e"];
		[row1 addObject:  @"r"];
		[row1 addObject:  @"t"];
		[row1 addObject:  @"y"];
		[row1 addObject:  @"u"];
		[row1 addObject:  @"i"];
		[row1 addObject:  @"o"];
		[row1 addObject:  @"p"];
		 
		[boardArrays insertObject: row1 atIndex:0];
		
		
		
	}
	
	return self;
}

- (void)dealloc {
	[boardArrays release];
    [super dealloc];
}

@end
