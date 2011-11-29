//
//  KeyboardCharacters.h
//  pce
//
//  Created by terrence pietrondi on 11/25/11.
//  Copyright 2011 pietrondi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KeyboardCharacters : NSObject {
	NSMutableArray *boardArrays;
	NSMutableDictionary *lookupCache;
}

@property(nonatomic,retain) NSMutableArray *boardArrays;
@property(nonatomic,retain) NSMutableDictionary *lookupCache;
-(id) init;
-(void) buildBoards;
-(void) buildWhatsAroundCache;
-(NSArray *) whatsAround : (NSString*) source; 
-(NSMutableArray *) indexOf : (NSString*) value; 
-(BOOL) isAround :(NSString*)source: (NSString*)target;
-(BOOL) binarySearch:(NSString*) source:(NSArray*) around;

@end
