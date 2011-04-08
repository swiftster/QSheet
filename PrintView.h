//
//  PrintView.h
//  PaperQ
//
//  Created by Jason Tratta on 12/3/09.
//  Copyright 2009 Sound Character. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PrintView : NSView {
	
	
	NSArray *workspaces;
    NSMutableAttributedString *atString;
    NSLayoutManager *layoutManager;
    BOOL isTitleBlockDrawn;
	

	

}

@property (readwrite, assign) NSArray *workspaces; 
@property (readwrite, assign) NSMutableAttributedString *atString;

@property (readwrite, assign) BOOL isTitleBlockDrawn;




@end
