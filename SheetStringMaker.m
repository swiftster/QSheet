//
//  SheetStringMaker.m
//  PaperQ
//
//  Created by Jason Tratta on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SheetStringMaker.h"


@implementation SheetStringMaker

@synthesize atString;
@synthesize workspaces;


-(id)init 
{ 
    
    atString = [[NSMutableAttributedString alloc] init]; 
    
    return self;
    
    
}

-(void)setUpTitleBlock 
{ 
    
 
        
        
        // Make a dictionary of attributes
        NSMutableDictionary *topTitleDic = [NSMutableDictionary dictionary];
        [topTitleDic setObject:[NSColor blackColor]
                        forKey:NSForegroundColorAttributeName];
        
         // Create an attributed string
         atString = [[NSMutableAttributedString alloc] initWithString:@"Production Cue Sheet" attributes:topTitleDic];
         
          
        
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
    
            
        
        NSFont *twelveFont = [NSFont boldSystemFontOfSize:12];
        NSMutableDictionary *cueSubFont = [NSMutableDictionary dictionary];
        [cueSubFont setObject:twelveFont forKey:NSFontAttributeName];
     
        
        
        NSMutableAttributedString *cueString = [[NSMutableAttributedString alloc] initWithString:@"#" attributes:cueSubFont]; 
        NSMutableAttributedString *cueName = [[NSMutableAttributedString alloc] initWithString:@"Q" attributes:cueSubFont]; 
        NSMutableAttributedString *noteString = [[NSMutableAttributedString alloc] initWithString:@"Notes" attributes:cueSubFont]; 
        
        
    
        NSMutableAttributedString *targetString = [[NSMutableAttributedString alloc] initWithString:@"Target" attributes:cueSubFont];
        
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
    
    
    //Line Break  
    NSAttributedString *lineBreak = [[NSAttributedString alloc] initWithString:@"\n"]; 
    [atString appendAttributedString:lineBreak]; 
        
        
        
        
    
    
} 

-(void)displayCueArray  
{ 
    
   // NSLog(@"atSting Start:%@",atString);
    
    NSFont *twelveFont = [NSFont fontWithName:@"Helvetica" size:12];
    NSMutableDictionary *cueSubFont = [NSMutableDictionary dictionary];
    [cueSubFont setObject:twelveFont forKey:NSFontAttributeName];
    
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
                                                initWithString:[cue valueForKey:@"qNumber"] attributes:cueSubFont]; 
        
        
        NSMutableAttributedString *cueName = [[NSMutableAttributedString alloc] 
                                              initWithString:[cue valueForKey:@"qName"]attributes:cueSubFont]; 
        
        NSString *longTarget = [cue valueForKey:@"fileTarget"];
         
     
        NSString *shortendString = [longTarget lastPathComponent];
        
        NSMutableAttributedString *targetString = [[NSMutableAttributedString alloc] 
                                                   initWithString:shortendString attributes:cueSubFont];
        
        //This method of spacing is prob not going to work consistantly. !!!!!
        
        NSAttributedString *singleTab = [[NSAttributedString alloc] initWithString:@"\t"]; 
        NSAttributedString *threeTabs = [[NSAttributedString alloc] initWithString:@"\t \t \t \t \t"];
        NSAttributedString *fiveTabs = [[NSAttributedString alloc] initWithString:@"\t \t \t"];
        
        
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
    
    
    
        
    
    
}





@end
