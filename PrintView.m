//
//  PrintView.m
//  PaperQ
//
//  Created by Jason Tratta on 12/3/09.
//  Copyright 2009 Sound Character. All rights reserved.
//

#import "PrintView.h"



@implementation PrintView

@synthesize workspaces;
@synthesize atString;
@synthesize isTitleBlockDrawn;




- (id)initWithFrame:(NSRect)frame 
{
       
     [super initWithFrame:frame];

    
    
    // Create an attributed string
    atString = [[NSMutableAttributedString alloc] init];

    

    return self;
}






- (void)dealloc
{
    [atString release];
    [super dealloc];
}


- (void)drawRect:(NSRect)rect 
{
    // Draw the string
  
   // [super drawRect:rect];
    
   // [[NSColor whiteColor] set];
   // [NSBezierPath fillRect:[self bounds]];
   
    
    
    
    [atString drawInRect:[self bounds]];
   
}




@end
