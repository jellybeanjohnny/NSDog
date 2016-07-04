//
//  BuildingNSDog.m
//  BuildingNSDog
//
//  Created by Matt Amerige on 7/3/16.
//  Copyright © 2016 Wubbyland. All rights reserved.
//

#import "BuildingNSDog.h"

void printDogWithBodyString(NSString *body);
NSUInteger longestStringLength(NSArray <NSString *> *array);

void ExtendNSLog(NSString *format, ...) {
	
	// Type to hold information about variable arguments.
	va_list ap;
 
	// Initialize a variable argument list.
	va_start (ap, format);
	
	NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
	
	// End using variable argument list.
	va_end (ap);
	
	printDogWithBodyString(body);
}

void printDogWithBodyString(NSString *body) {
	
	if ([body isEqualToString:@""]) {
		// WASTING DOG
		body = [body stringByAppendingString:@"STOP WASTING DOGS >:("];
	}
	
	// Array of strings containing the dog ASCII
	NSArray *rightDogArray = @[@"░░░░░░░░░░░░░░░░░░░░░░░░░░██░░████████░░██░░░░",
														 @"░░░░░░░░░░░░░░░░░░░░░░░░██░░██░░░░░░░░██░░██░░",
														 @"░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░██░░",
														 @"░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░██░",
														 @"░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░██░░░░██░░░░██",
														 @"░░░░░░░░░░░░░░░░████░░░░░░░░░░░░░░░░░░░░░░░░██",
														 @"░░██████████████░░░░░░░░░░░░░░░░░░████░░░░░░██",
														 @"██░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░██░░██░░██",
														 @"░░██████░░░░░░░░░░░░░░░░░░░░░░░░████████░░░░██",
														 @"░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██",
														 @"░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██",
														 @"░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██",
														 @"░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██",
														 @"░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██",
														 @"░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░",
														 @"░░░░░░░░██░░░░████░░░░████████░░░░████░░░░██░░",
														 @"░░░░░░░░██░░░░██░░██░░██░░░░░░██░░████░░░░██░░",
														 @"░░░░░░░░░░██░░██░░░░██░░░░░░░░░░██░░░░██░░██░░",
														 @"░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░"
														 ];
	
	
	// Separate the Body string into an array of strings separated by new line
	NSMutableArray *bodyArray = [[NSMutableArray alloc] initWithArray:[body componentsSeparatedByString:@"\n"]];
	
	// Get the longest string so we can determine how big the speech box needs to be for width
	NSUInteger speechBoxWidth = longestStringLength(bodyArray) + 5;
	
	BOOL speechBoxBottomWasPlaced = NO;
	
	// The leading space between the speech box and the dog
	int leadingSpace = 3;
	
	// Giving this an impossible index to start with. it will get assigned when we know what the index is later on.
	NSUInteger speechBoxBottomIndex = -10;
	NSUInteger speechBoxTopIndex = 0;
	
	// The start of where a speech box can come from
	NSUInteger dogMouthTopIndex = 7;
	
	// The end of where a speech box can come from.
	NSUInteger dogMouthBottomIndex = 8;
	
	// Determine the amount of times we need to loop.
	// It's either the dog array count or the bodyArraycount +1
	NSUInteger count = rightDogArray.count > bodyArray.count ? rightDogArray.count : bodyArray.count + 1;
	
	NSString *dogLine = [rightDogArray firstObject];
	NSUInteger dogLineLength = dogLine.length;
	
	for (NSUInteger index = 0; index <= count; index++) {
		NSMutableString *resultString = [[NSMutableString alloc] initWithString:@""];
		
		if (index > rightDogArray.count - 1) {
			// No more dog! Append empty space that is the same length as a dog line
			[resultString appendFormat:@"%*s", (int)dogLineLength, ""];
		}
		else {
			NSString *dogLineString = rightDogArray[index];
			[resultString appendString:dogLineString];
		}
		
		// Dealing with the leading space...
		if (index == dogMouthTopIndex || (index == dogMouthBottomIndex && !speechBoxBottomWasPlaced)) {
			// This is where the dog's mouth is, so I'm adding 3 zeroes without any leading space to create a speech bubble from the dog's mouth
			[resultString appendFormat:@"%0*d", leadingSpace, 0];
		}
		else if (!speechBoxBottomWasPlaced || index < dogMouthBottomIndex) {
			// Appending two spaces and a zero to the line. We only need to do this until the speechBubbleBottom is placed or if we are above(spacially) the dogMouthBottomIndex
			[resultString appendFormat:@"%*s0", leadingSpace - 1, ""];
		}
		
		// The very top of the speechBox
		if (index == speechBoxTopIndex) {
			// The is the first line so just print the top frame of the box along with the first line of the dog
			[resultString appendFormat:@"%0*d",(int)speechBoxWidth, 0];
		}
		else {
			// Pop a string off the from the bodyString array and append it to the dog line
			if (bodyArray.count > 0) {
				NSString *bodyString = [bodyArray firstObject];
				[bodyArray removeObjectAtIndex:0];
				if (bodyArray.count == 0) {
					// Place the speech box bottom on the next line
					speechBoxBottomIndex = index + 1;
				}
				[resultString appendFormat:@" %@%*s 0", bodyString, (int)(speechBoxWidth - bodyString.length) - leadingSpace, ""];
			}
			else if (index == speechBoxBottomIndex) {
				speechBoxBottomWasPlaced = YES;
				// This is the last line of input text so fill out the bottom of the speech box
				[resultString appendFormat:@"%0*d", (int)speechBoxWidth, 0];
			}
		}
		printf("%s\n", [resultString UTF8String]);
	}
	printf("\n");
}

NSUInteger longestStringLength(NSArray <NSString *> *array) {
	
	NSUInteger longest = 0;
	
	for (NSString *string in array) {
		if (string.length > longest) {
			longest = string.length;
		}
	}
	return longest;
}
