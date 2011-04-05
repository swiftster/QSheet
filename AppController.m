//
//  MyDocument.m
//  PaperQ
//
//  Created by jtratta on 9/26/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import "AppController.h"
#import "ImportOp.h"

@implementation AppController

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

-(IBAction)test:(id)sender
{ 
    NSFetchRequest *request = [[NSFetchRequest alloc] init]; 
    [request setEntity:[NSEntityDescription entityForName:@"Workspace" inManagedObjectContext:[self managedObjectContext]]]; 
    NSError *error = nil; 
    NSArray *result = [[self managedObjectContext]executeFetchRequest:request error:&error];
    NSLog(@"Result:%i",[result count]);
    [printView setWorkspaces:result]; 
    [printView displayCueArray]; 
    
}
	

-(void)sendTheWorkspace 
{ 
    NSFetchRequest *request = [[NSFetchRequest alloc] init]; 
    [request setEntity:[NSEntityDescription entityForName:@"Workspace" inManagedObjectContext:[self managedObjectContext]]]; 
    NSError *error = nil; 
    NSArray *result = [[self managedObjectContext]executeFetchRequest:request error:&error];
    NSLog(@"Result:%i",[result count]);
    [printView setWorkspaces:result]; 
    [printView displayCueArray]; 
}


@end
