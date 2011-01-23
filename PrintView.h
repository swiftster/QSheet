//
//  PrintView.h
//  PaperQ
//
//  Created by Jason Tratta on 12/3/09.
//  Copyright 2009 Sound Character. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PrintView : NSView {
	
	
	NSManagedObject *workspaces;
	
	float lineHeight; 
	NSRect pageRect; 
	int linesPerPage; 
	int currentPage; 
	

}

@property (readwrite, assign) NSManagedObject *workspaces; 


-(id)initWithWorkspaces:(NSArray *)workspace;

@end
