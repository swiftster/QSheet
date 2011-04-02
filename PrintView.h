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
    NSMutableAttributedString *atString;
	

	

}

@property (readwrite, assign) NSManagedObject *workspaces; 


-(id)initWithWorkspaces:(NSArray *)workspace;

@end
