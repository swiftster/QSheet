//
//  MyDocument.h
//  PaperQ
//
//  Created by jtratta on 9/26/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PrintView.h"

@interface AppController : NSPersistentDocument {
	
	NSOperationQueue *genericOperationQueue;
	NSOperation *queue;
	
	NSToolbarItem *importButton; 
	NSPanel *inspectorWindow;
    
    IBOutlet PrintView *printView; 
    
    NSMutableAttributedString *saveViewString; 
	
	
}

@property (readwrite, retain) NSMutableAttributedString *saveViewString; 

- (IBAction)import:(id)sender;
-(IBAction)test:(id)sender; 


@end
