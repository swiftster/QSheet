//
//  SheetStringMaker.h
//  PaperQ
//
//  Created by Jason Tratta on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SheetStringMaker : NSObject {
    
    
    NSMutableAttributedString *atString; 
    NSArray *workspaces;
    
}


@property (readwrite, retain) NSMutableAttributedString *atString;
@property (readwrite, assign) NSArray *workspaces;

-(void)setUpTitleBlock;
-(void)addCues;
-(void)displayCueArray;


@end
