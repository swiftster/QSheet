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


- (id)initWithFrame:(NSRect)frame 
{
    [super initWithFrame:frame];
    
    // Make a dictionary of attributes
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    [d setObject:[NSColor greenColor]
          forKey:NSForegroundColorAttributeName];
    
    // Create an attributed string
    atString = [[NSMutableAttributedString alloc] initWithString:@"This is the stuff" 
                                                      attributes:d];
    
    // Underline the last word
    d = [NSMutableDictionary dictionary];
    [d setObject:[NSNumber numberWithInt:1]
          forKey:NSUnderlineStyleAttributeName];
    
    // Change the attributes over a range
    [atString setAttributes:d range:NSMakeRange(12, 5)];
    
    // Put it in a big font
    NSFont *f = [NSFont fontWithName:@"Helvetica" size:64];
    d = [NSMutableDictionary dictionary];
    [d setObject:f
          forKey:NSFontAttributeName];
    [atString addAttributes:d range:NSMakeRange(0, 17)];    
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
    [atString drawInRect:[self bounds]];
}



@end
