//
//  PrintView.h
//  PaperQ
//
//  Created by Jason Tratta on 12/3/09.
//  Copyright 2009 Sound Character. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PrintView : NSTextView {
	
	
	NSArray *workspaces;
    NSTextStorage *atString;
    NSLayoutManager *layoutManager;
	

	

}

@property (readwrite, assign) NSArray *workspaces; 
@property (readwrite, assign) NSTextStorage *atString;


//-(id)initWithWorkspaces:(NSArray *)workspace;

-(void)setUpTitleBlock;
-(void)addCues;
-(void)displayCueArray;

@end
