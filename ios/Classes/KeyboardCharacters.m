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
	NSLog(@"buildBoards: Enter");
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
	
	[boardArrays insertObject: row3 atIndex:2];
	
	NSLog(@"buildBoards: Exit");
}

-(void) buildWhatsAroundCache{
	NSLog(@"buildWhatsAroundCache: Enter");

	lookupCache = [[NSMutableDictionary alloc] init];
	
	for (NSMutableArray *nextRow in boardArrays) {
		for (NSString *nextCol in nextRow) {
			NSLog(@"buildWhatsAroundCache: next string to check what's around: %@", nextCol);
			NSMutableArray* around = [self whatsAround: nextCol];
			NSLog(@"buildWhatsAroundCache: around array: %@", around);
			
			[lookupCache setObject:around forKey:nextCol];
		}
	}
	
	NSLog(@"buildWhatsAroundCache: Exit");
}

-(NSMutableArray*) whatsAround:(NSString*) source{
	NSLog(@"whatsAround: Enter: %@",source);
	NSMutableArray *around = [NSMutableArray arrayWithCapacity:9];
	NSMutableArray *sourceCords = [self indexOf: source];
	NSLog(@"whatsAround: source cords: %@",sourceCords);
	
	NSString *nextAround;
	@try {	
		//nextAround 	= [self boardsArrays[sourceCords[0] - 1][sourceCords[1]]; 
		//NSUInteger *rowInd = (NSUInteger*)[sourceCords objectAtIndex:0 - 1];
		//NSUInteger *colInd = (NSUInteger*)[sourceCords objectAtIndex: 1];
		//NSMutableArray *col = [ boardArrays objectAtIndex: [rowInd intValue]];
		//nextAround = (NSString*)[col objectAtIndex: colInd];
		nextAround = nil;
		
	} @catch (NSException *exception) { 
		nextAround = nil; 
	}
	if( nextAround != nil) { 
		[around addObject:nextAround];
	}
	
	return around;
}

-(NSMutableArray *) indexOf : (NSString*) value{
	NSLog(@"indexOf: Enter: %@",value);
	NSMutableArray *indexSet = [NSMutableArray arrayWithCapacity:2];
	
	NSUInteger row=0;
	for (NSMutableArray *nextRow in boardArrays) {
		NSLog(@"indexOf: row: %@",row);
		NSUInteger col = [nextRow indexOfObject: value];
		NSLog(@"indexOf: col: %@",col);
		
		if(col  != NSNotFound){
			NSNumber *rowNum = [NSNumber numberWithInteger: row];
			NSNumber *colNum = [NSNumber numberWithInteger: col];
			
			[indexSet addObject:rowNum];
			[indexSet addObject: colNum];
			
			NSLog(@"indexOf: index set: %@",indexSet);
			
			break;
		} else {
			NSLog(@"indexOf: value not found in column: %@",col);
		}
		
		row++;
	}
	
	NSLog(@"indexOf: Exit: %@",indexSet);
	return indexSet;
}


- (void)dealloc {
	[boardArrays release];
	[super dealloc];
}

@end
