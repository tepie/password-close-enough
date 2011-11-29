//
//  KeyboardDigits.m
//  pce
//
//  Created by terrence pietrondi on 11/29/11.
//  Copyright 2011 pietrondi. All rights reserved.
//

#import "KeyboardDigits.h"
#import "KeyboardCharacters.h"


@implementation KeyboardDigits

- (void) buildBoards{
	NSLog(@"buildBoards: Enter");
	boardArrays = [NSMutableArray arrayWithCapacity:1];
	
	NSMutableArray *row1 = [NSMutableArray arrayWithCapacity:10];
	[row1 addObject:  @"1"];
	[row1 addObject:  @"2"];
	[row1 addObject:  @"3"];
	[row1 addObject:  @"4"];
	[row1 addObject:  @"5"];
	[row1 addObject:  @"6"];
	[row1 addObject:  @"7"];
	[row1 addObject:  @"8"];
	[row1 addObject:  @"9"];
	[row1 addObject:  @"0"];
	
	[boardArrays insertObject: row1 atIndex:0];
	
	NSLog(@"buildBoards: Exit");
}

@end
