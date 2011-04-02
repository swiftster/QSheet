//
//  MyDocument.h
//  PaperQ
//
//  Created by jtratta on 9/26/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PrintView.h"

@interface MyDocument : NSPersistentDocument {
	
	NSOperationQueue *genericOperationQueue;
	NSOperation *queue;
	
	NSToolbarItem *importButton; 
	NSPanel *inspectorWindow;
    
    IBOutlet PrintView *printView; 
	
	
}

- (IBAction)import:(id)sender;


@end
