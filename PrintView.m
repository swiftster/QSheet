//
//  PrintView.m
//  PaperQ
//
//  Created by Jason Tratta on 12/3/09.
//  Copyright 2009 Sound Character. All rights reserved.
//

#import "PrintView.h"

@synthesize workspaces 


@implementation PrintView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(id)initWithWorkspaces:(NSArray *)workspace 
{ 
	//Call the superclass init with dummy frame 
	[super initWithFrame:NSMakeRect(0, 0, 700, 700)];
	 workspaces = workspace; 
	
	
	return self; 
	 
}



#pragma mark Pagnation 

-(BOOL)knowsPageRange:(NSRangePointer)range 
{ 
	NSPrintOperation *po = [NSPrintOperation currentOperation]; 
	NSPrintInfo *printInfo = [po printInfo]; 
	
	//Where Can I Draw?
	pageRect = [printInfo imageablePageBounds]; 
	NSRect newFrame; 
	newFrame.origin = NSZeroPoint; 
	newFrame.size = [printInfo paperSize]; 
	[self setFrame:newFrame]; 
	
	//How Many Lines Per Page?
	linesPerPage = pageRect.size.height / lineHeight; 
	
	//Pages are 1 based
	range->location = 1;
	
	//How Many pages will it take?
	
	
	return YES; 
	
}
	

-(NSRect)rectForPage:(NSInteger)page 
{ 
	//Note the current page 
	currentPage = i - 1; 
	
	//Return the same page rect everytime 
	return pageRect; 
	
}

#pragma mark drawing 

-(BOOL)isFlipped 
{ 
	return YES; 

}


- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	
	NSRect nameRect; 
	NSRect raiseRect; 
	
	raiseRect.size.height = nameRect.size.height = lineHeight; 
	nameRect.size.width = 200.0; 
	raiseRect.origin.x = NSMaxX(nameRect); 
	raiseRect.size.width = 100.0; 
	
}


@end
