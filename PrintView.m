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


- (id)init
{
    [super init];
   
    
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textStorageChanged:)
                                                name:NSTextStorageDidProcessEditingNotification
                                               object:atString];

    return self;
}




-(void)awakeFromNib 
{ 
    layoutManager = [self layoutManager]; 
    
    
    [self setUpTitleBlock]; 
    [self addCues]; 
    
    [layoutManager replaceTextStorage:atString];  
    
}

- (void)dealloc
{
    [atString release];
    [super dealloc];
}

/*
- (void)drawRect:(NSRect)rect 
{
    // Draw the string
    //[atString drawInRect:[self bounds]];
}
*/

- (void)textStorageChanged:(NSNotification *)note
{
   // NSLog(@"DID CHANGE");
    [self setNeedsDisplay:YES];
}

-(void)setUpTitleBlock 
{ 
   
    
    // Make a dictionary of attributes
    NSMutableDictionary *topTitleDic = [NSMutableDictionary dictionary];
    [topTitleDic setObject:[NSColor blackColor]
          forKey:NSForegroundColorAttributeName];
    
    // Create an attributed string
    atString = [[NSTextStorage alloc] initWithString:@"Production Cue Sheet" attributes:topTitleDic];
    
    
    // Put it in a big font
    NSFont *twentyFont = [NSFont fontWithName:@"Helvetica" size:20];
    topTitleDic = [NSMutableDictionary dictionary];
    [topTitleDic setObject:twentyFont
          forKey:NSFontAttributeName];
    [atString addAttributes:topTitleDic range:NSMakeRange(0, 20)];  
    
    //Line Break  
    NSAttributedString *lineBreak = [[NSAttributedString alloc] initWithString:@"\n"]; 
    [atString appendAttributedString:lineBreak]; 
    
    

 //Add the Production Title Block
    
    NSFont *fourteenFont = [NSFont fontWithName:@"Helvetica" size:14];
    NSMutableDictionary *titleSubFont = [NSMutableDictionary dictionary];
    [titleSubFont setObject:fourteenFont forKey:NSFontAttributeName];
    
    NSMutableAttributedString *productionBlock = [[NSMutableAttributedString alloc] initWithString:@"Production Title" attributes:titleSubFont];
    
    int i = [productionBlock length]; 
    [productionBlock addAttributes:titleSubFont range:NSMakeRange(0, i)];
    
    [atString appendAttributedString:productionBlock]; 
    
    
    //Line Break 
    [atString appendAttributedString:lineBreak];
    
    
//Add The Theatre Space Name 
    
    NSMutableDictionary *performanceSpaceDic = [NSMutableDictionary dictionary]; 
    [performanceSpaceDic setObject:fourteenFont forKey:NSFontAttributeName]; 
    
    NSMutableAttributedString *performanceSpaceBlock = [[NSMutableAttributedString alloc] 
                                                            initWithString:@"Theatre Space" attributes:performanceSpaceDic]; 
    
    
    i = [performanceSpaceBlock length]; 
    [performanceSpaceBlock addAttributes:performanceSpaceDic range:NSMakeRange(0,i)];
    
    [atString appendAttributedString:performanceSpaceBlock]; 
     
    
    //Line break 
    [atString appendAttributedString:lineBreak]; 
    
    
    //Designer Name 
    
    NSMutableDictionary *designerNameDict = [NSMutableDictionary dictionary]; 
    [designerNameDict setObject:fourteenFont forKey:NSFontAttributeName]; 
    
    NSMutableAttributedString *designerNameBlock = [[NSMutableAttributedString alloc] initWithString:@"Designer Name" attributes:designerNameDict]; 
    i = [designerNameBlock length]; 
    [designerNameBlock addAttributes:designerNameDict range:NSMakeRange(0, i)];  
    
    [atString appendAttributedString:designerNameBlock]; 
    
    //Line Break 
    [atString appendAttributedString:lineBreak]; 
    
    
    //Date  
    
  
    
    NSMutableDictionary *dateDic = [NSMutableDictionary dictionary]; 
    [dateDic setObject:fourteenFont forKey:NSFontAttributeName]; 
    
    NSMutableAttributedString *dateBlock = [[NSMutableAttributedString alloc] initWithString:@"Date:"]; 
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
    [dateFormatter setDateFormat:@"MM-dd-yyyy"]; 
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]]; 
        
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:dateString]; 
    [dateBlock appendAttributedString:attString]; 
    
    i = [dateBlock length]; 
    [dateBlock addAttributes:dateDic range:NSMakeRange(0, i)]; 
    
    [atString appendAttributedString:dateBlock]; 
    
    //Line Break 
    [atString appendAttributedString:lineBreak]; 
    [atString appendAttributedString:lineBreak]; 
    [atString appendAttributedString:lineBreak];

}


-(void)addCues 
{ 
    
    NSMutableAttributedString *cueString = [[NSMutableAttributedString alloc] initWithString:@"#"]; 
    NSMutableAttributedString *cueName = [[NSMutableAttributedString alloc] initWithString:@"Q"]; 
    NSMutableAttributedString *noteString = [[NSMutableAttributedString alloc] initWithString:@"Notes"]; 
    NSMutableAttributedString *targetString = [[NSMutableAttributedString alloc] initWithString:@"Target"];
    
    NSAttributedString *singleTab = [[NSAttributedString alloc] initWithString:@"\t"]; 
    NSAttributedString *threeTabs = [[NSAttributedString alloc] initWithString:@"\t \t \t \t \t"];
    NSAttributedString *fiveTabs = [[NSAttributedString alloc] initWithString:@"\t \t \t \t \t"];
    
    [atString appendAttributedString:cueString];
    [atString appendAttributedString:singleTab];
    [atString appendAttributedString:cueName]; 
    [atString appendAttributedString:threeTabs];
    [atString appendAttributedString:noteString]; 
    [atString appendAttributedString:fiveTabs];
    [atString appendAttributedString:targetString];  
    

    
} 

-(void)displayCueArray  
{ 
    //NSLog(@"Workspaces:%i",[workspaces count]);
    NSManagedObject *workspace = [workspaces objectAtIndex:0];  

    NSSet *theCueLists = [workspace valueForKey:@"cuelists"]; 
    NSArray *listArray = [theCueLists allObjects]; 
    
    NSManagedObject *aCueList = [listArray objectAtIndex:0]; 
    
    NSSet *aCues = [aCueList valueForKey:@"cues"];  
    
    NSArray *allCues = [aCues allObjects]; 
   
    
    
    for (NSManagedObject *cue in allCues) {
        
    NSLog(@"Cue #:%@",[cue valueForKey:@"qNumber"]);
        
    NSMutableAttributedString *cueString = [[NSMutableAttributedString alloc] 
                                            initWithString:[cue valueForKey:@"qNumber"]]; 
        
        
    NSMutableAttributedString *cueName = [[NSMutableAttributedString alloc] 
                                          initWithString:[cue valueForKey:@"qName"]]; 
        
    NSMutableAttributedString *targetString = [[NSMutableAttributedString alloc] 
                                               initWithString:[cue valueForKey:@"fileTarget"]];

    NSAttributedString *singleTab = [[NSAttributedString alloc] initWithString:@"\t"]; 
    NSAttributedString *threeTabs = [[NSAttributedString alloc] initWithString:@"\t \t \t \t \t"];
    NSAttributedString *fiveTabs = [[NSAttributedString alloc] initWithString:@"\t \t \t \t \t"];
    
    
    [atString appendAttributedString:cueString];
    [atString appendAttributedString:singleTab];
    [atString appendAttributedString:cueName]; 
    [atString appendAttributedString:threeTabs];
    
    [atString appendAttributedString:fiveTabs];
    [atString appendAttributedString:targetString];  
        
    //Line Break  
    NSAttributedString *lineBreak = [[NSAttributedString alloc] initWithString:@"\n"]; 
    [atString appendAttributedString:lineBreak]; 
        
        }
    
    [atString processEditing]; 
    [self setNeedsDisplay:YES]; 
  
    
}

@end
