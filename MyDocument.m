//
//  MyDocument.m
//  PaperQ
//
//  Created by jtratta on 9/26/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import "MyDocument.h"
#import "ImportOp.h"

@implementation MyDocument

- (id)init 
{
    self = [super init];
    if (self != nil) {
	queue = [[NSOperationQueue alloc] init];
    }
    
    printView = [[PrintView alloc] init]; 
    return self;
}

- (NSString *)windowNibName 
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    // user interface preparation code
}


- (IBAction)import:(id)sender
{
		ImportOp *operation = nil;
		operation = [[ImportOp alloc] initWithDelegate:self];
		if (!queue) {
			queue = [[NSOperationQueue alloc] init]; }
		
		
		ImportOp *op = nil;
		op = [[ImportOp alloc] initWithDelegate:self];
		
		if (!genericOperationQueue) {
			genericOperationQueue = [[NSOperationQueue alloc] init];
		}
		
		[genericOperationQueue addOperation:op];
		[op release], op = nil;
		
	}
	
	

	


@end
