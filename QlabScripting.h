
//  QlabScripting.h
//  QAutoSaver
//
//  Created by Jason Tratta on 6/10/09.
//  Copyright 2009 Sound Character. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferenceController.h"

@interface QlabScripting : NSObject {
	
int arrayNumber;
int incrementFileName;
BOOL active; 
NSFileManager *fileManager;
NSString *feedBackText; 
PreferenceController *myPrefs;
NSMutableArray *workspaces;
	
//Key Values 
NSString *workspaceName;



}

@property (readwrite, assign) NSString *feedBackText;
@property (readwrite, copy) NSString *workspaceName;
@property (assign) NSMutableArray *workspaces; 

// Grab SBElements from Qlab for other Methods. If Qlab Scriping Changes, these should be the only methods to change.
-(NSArray *)getWorkspaceArray;
-(NSArray *)getDocumentArray; 

-(int)numberofWorkspaces;


//Qlab Polling
-(BOOL)isRunning; 
-(BOOL)isQlabActive; 
-(BOOL)isModified; 

//Saveing and Backups
-(void) saveAllWorkspaces; 
-(void)saveSpecifiedWorkspace: (int) a; 
-(void)saveWorkspaceLogic; 
-(id) workspaceNamer;
-(void)moveFiles;
-(int)getArrayNumber;


//Controls
-(void)goCue;
-(void)moveSelectionUp; 
-(void)moveSelectionDown;
-(void)stopCue;
-(void)pause;
-(void)reset; 









@end
