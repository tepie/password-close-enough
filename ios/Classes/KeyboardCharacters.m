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
	[row2 addObject:  @"a"];
	[row2 addObject:  @"s"];
	[row2 addObject:  @"d"];
	[row2 addObject:  @"f"];
	[row2 addObject:  @"g"];
	[row2 addObject:  @"h"];
	[row2 addObject:  @"j"];
	[row2 addObject:  @"k"];
	[row2 addObject:  @"l"];
	
	[boardArrays insertObject: row2 atIndex:1];
	
	NSMutableArray *row3 = [NSMutableArray arrayWithCapacity:7];
	[row3 addObject:  @"z"];
	[row3 addObject:  @"x"];
	[row3 addObject:  @"c"];
	[row3 addObject:  @"v"];
	[row3 addObject:  @"b"];
	[row3 addObject:  @"n"];
	[row3 addObject:  @"m"];
	
	[boardArrays insertObject: row3 atIndex:2];
	
	NSLog(@"buildBoards: Exit");
}

-(void) buildWhatsAroundCache{
	NSLog(@"buildWhatsAroundCache: Enter");

	lookupCache = [[NSMutableDictionary alloc] init];
	
	for (NSMutableArray *nextRow in boardArrays) {
		for (NSString *nextCol in nextRow) {
			NSLog(@"buildWhatsAroundCache: next string to check what's around: %@", nextCol);
			NSArray* around = [self whatsAround: nextCol];
			NSLog(@"buildWhatsAroundCache: around array: %@", around);
			
			[lookupCache setObject:around forKey:nextCol];
		}
	}
	
	NSLog(@"buildWhatsAroundCache: look up cache: ");
	
	NSLog(@"buildWhatsAroundCache: Exit");
}

-(NSArray*) whatsAround:(NSString*) source{
	NSLog(@"whatsAround: Enter: %@",source);
	NSMutableArray *around = [NSMutableArray arrayWithCapacity:9];
	
	NSMutableArray *sourceCords = [self indexOf: source];
	NSLog(@"whatsAround: source cords: %@",sourceCords);
	
	NSNumber *sourceCorNumRow = (NSNumber *)[sourceCords objectAtIndex:0];
	NSInteger sourceCordRow = (NSInteger)[sourceCorNumRow integerValue];
	NSNumber* sourceCorNumCol = (NSNumber *)[sourceCords objectAtIndex:1];
	NSInteger sourceCordCol = (NSInteger)[sourceCorNumCol integerValue];

	
	NSString *nextAround;
	@try {	
		NSMutableArray *row = (NSMutableArray*)[boardArrays objectAtIndex: sourceCordRow -1];
		nextAround = (NSString*)[row objectAtIndex:sourceCordCol];
	} @catch (NSException *exception) {  nextAround = nil; }
	if( nextAround != nil) { [around addObject:nextAround]; }
	
	@try {	
		NSMutableArray *row = (NSMutableArray*)[boardArrays objectAtIndex: sourceCordRow +1];
		nextAround = (NSString*)[row objectAtIndex:sourceCordCol];
	} @catch (NSException *exception) {  nextAround = nil; }
	if( nextAround != nil) { [around addObject:nextAround]; }
	
	@try {	
		NSMutableArray *row = (NSMutableArray*)[boardArrays objectAtIndex: sourceCordRow];
		nextAround = (NSString*)[row objectAtIndex:sourceCordCol - 1];
	} @catch (NSException *exception) {  nextAround = nil; }
	if( nextAround != nil) { [around addObject:nextAround]; }
	
	@try {	
		NSMutableArray *row = (NSMutableArray*)[boardArrays objectAtIndex: sourceCordRow];
		nextAround = (NSString*)[row objectAtIndex:sourceCordCol + 1];
	} @catch (NSException *exception) {  nextAround = nil; }
	if( nextAround != nil) { [around addObject:nextAround]; }
	
	@try {	
		NSMutableArray *row = (NSMutableArray*)[boardArrays objectAtIndex: sourceCordRow - 1];
		nextAround = (NSString*)[row objectAtIndex:sourceCordCol + 1];
	} @catch (NSException *exception) {  nextAround = nil; }
	if( nextAround != nil) { [around addObject:nextAround]; }
	
	@try {	
		NSMutableArray *row = (NSMutableArray*)[boardArrays objectAtIndex: sourceCordRow + 1];
		nextAround = (NSString*)[row objectAtIndex:sourceCordCol - 1];
	} @catch (NSException *exception) {  nextAround = nil; }
	if( nextAround != nil) { [around addObject:nextAround]; }
	
	@try {	
		NSMutableArray *row = (NSMutableArray*)[boardArrays objectAtIndex: sourceCordRow - 1];
		nextAround = (NSString*)[row objectAtIndex:sourceCordCol - 1];
	} @catch (NSException *exception) {  nextAround = nil; }
	if( nextAround != nil) { [around addObject:nextAround]; }
	
	@try {	
		NSMutableArray *row = (NSMutableArray*)[boardArrays objectAtIndex: sourceCordRow + 1];
		nextAround = (NSString*)[row objectAtIndex:sourceCordCol + 1];
	} @catch (NSException *exception) {  nextAround = nil; }
	if( nextAround != nil) { [around addObject:nextAround]; }
	
	NSArray *sortedAround = [around sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	NSLog(@"whatsAround: Exit: %@",sortedAround);
	return sortedAround;
}

-(NSMutableArray *) indexOf : (NSString*) value{
	NSLog(@"indexOf: Enter: %@",value);
	NSMutableArray *indexSet = [NSMutableArray arrayWithCapacity:2];
	
	int row=0;
	for (NSMutableArray *nextRow in boardArrays) {
		//NSLog(@"indexOf: row: %@",row);
		int col = [nextRow indexOfObject: value];
		
		if(col  != NSNotFound){
			//NSLog(@"indexOf: col: %@",col);
			NSNumber *rowNum = [NSNumber numberWithInteger: row];
			NSNumber *colNum = [NSNumber numberWithInteger: col];
			
			[indexSet addObject:rowNum];
			[indexSet addObject: colNum];
			
			//NSLog(@"indexOf: index set: %@",indexSet);
			
			break;
		} else {
			//NSLog(@"indexOf: value not found in row: %@",row);
		}
		
		row = row +1;
	}
	
	NSLog(@"indexOf: Exit: %@",indexSet);
	return indexSet;
}

-(BOOL) isAround:(NSString *)source :(NSString *)target{
	NSArray* around = (NSArray* )[lookupCache objectForKey: source];
	if(around != nil){
		return [self binarySearch : target : around];
	} else {
		return FALSE;
	}
	
}

-(BOOL) binarySearch:(NSString*) source:(NSArray*) around{
	// https://wiki.colby.edu/display/~bkgiertl/Binary+Search+in+Objective-C
	
	int min = 0, max = [around count], mid;
	
	BOOL foundValue = false;
	
	NSLog(@"we are checking our array for value %i",source);
	
	while (min<max ) {
		
		mid = (min+max)/2;
		NSLog(@"min = %i , max = %i, mid = %i",min,max,mid);
		NSString *next =  [around objectAtIndex: mid];
		if (next == source){
			foundValue = true; 
			break;
		} else if (source > next){
			min = mid+1;
		} else{
			max = mid-1;
		}
	}
	
	NSLog(@"foundValue = %i",foundValue);
	
	return foundValue;
}


- (void)dealloc {
	[boardArrays release];
	[super dealloc];
}

@end
