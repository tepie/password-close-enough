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
@synthesize lookupCache;

-(id) init {
	if (self = [super init]){
		[self buildBoards];
		[self buildWhatsAroundCache];
	}
	
	return self;
}

- (void) buildBoards{
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
	
	NSMutableArray *row2 = [NSMutableArray arrayWithCapacity:9];
	[row1 addObject:  @"a"];
	[row1 addObject:  @"s"];
	[row1 addObject:  @"d"];
	[row1 addObject:  @"f"];
	[row1 addObject:  @"g"];
	[row1 addObject:  @"h"];
	[row1 addObject:  @"j"];
	[row1 addObject:  @"k"];
	[row1 addObject:  @"l"];
	
	[boardArrays insertObject: row2 atIndex:1];
	
	NSMutableArray *row3 = [NSMutableArray arrayWithCapacity:7];
	[row1 addObject:  @"z"];
	[row1 addObject:  @"x"];
	[row1 addObject:  @"c"];
	[row1 addObject:  @"v"];
	[row1 addObject:  @"b"];
	[row1 addObject:  @"n"];
	[row1 addObject:  @"m"];
	
	[boardArrays insertObject: row3 atIndex:3];
}

-(void) buildWhatsAroundCache{
	
}

- (void)dealloc {
	[boardArrays release];
    [super dealloc];
}

@end
