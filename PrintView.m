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
    NSLog(@"Print View Init");
    [super initWithFrame:frame];
    
    // Make a dictionary of attributes
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    [d setObject:[NSColor blackColor]
          forKey:NSForegroundColorAttributeName];
    
    // Create an attributed string
    atString = [[NSMutableAttributedString alloc] initWithString:@"Production Cue Sheet" attributes:d];

    
    // Put it in a big font
    NSFont *f = [NSFont fontWithName:@"Helvetica" size:20];
    d = [NSMutableDictionary dictionary];
    [d setObject:f
          forKey:NSFontAttributeName];
    [atString addAttributes:d range:NSMakeRange(0, 20)];    
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
