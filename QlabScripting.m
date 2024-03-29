
//  QlabScripting.m
//  QAutoSaver
//
//  Created by Jason Tratta on 6/10/09.
//  Copyright 2009 Sound Character. All rights reserved.
//

#import "QlabScripting.h"
#import	"Qlab.h"


NSString const * JATFeedBackNotification = @"JATFeedBackPost";

@implementation QlabScripting

@synthesize feedBackText;
@synthesize workspaceName; 
@synthesize workspaces; 


-(id)init
{
	[super init]; 

	
	
	
	return self;
}	


-(NSArray *)getWorkspaceArray 
{ 
	QlabApplication *qLab = [SBApplication applicationWithBundleIdentifier:@"com.figure53.Qlab.2"]; 
	NSArray *array = [qLab workspaces];
	
	return array;

}

-(NSArray *)getDocumentArray
{
	QlabApplication *qLab = [SBApplication applicationWithBundleIdentifier:@"com.figure53.Qlab.2"]; 
	NSArray *array = [qLab documents];
	
	return array; 
}

-(int)numberofWorkspaces
{ 
	
	
	NSArray *array = [self getWorkspaceArray]; 
	int arrayCount; 
	arrayCount = [array count]; 
	
	[array release]; 
	return arrayCount; 
	
}

	

#pragma mark -
#pragma mark Qlab Polling
#pragma mark -

// Method to find any running cues 
-(BOOL)isRunning 
{ 
	
	NSArray *array;
	array = [self getWorkspaceArray];
	NSArray *cuesRunning;
	int i;
	int c;
	BOOL running = FALSE;
	NSInteger arrayCount = [array count]; 
	int cueCount;
	
	for (i = 0; i < arrayCount; i++){
		
		cuesRunning = [[array objectAtIndex:i]cues];
		cueCount = [cuesRunning count]; 
		
		for (c = 0; c < cueCount; c++){
			
			if([[cuesRunning objectAtIndex:c]running] == TRUE) { 
				NSLog(@"Cue Running"); 
				running = TRUE; 
				
			} else { 
				running = FALSE;
			NSLog(@"No Cue Running"); }
			
		}
	}
	
	return running;
	[array release]; 
	[cuesRunning release];
	
}

//Is the QLab Application Running?
-(BOOL)isQlabActive 
{ 
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; 
	
	QlabApplication *qLab = [SBApplication applicationWithBundleIdentifier:@"com.figure53.Qlab.2"]; 
	
	if ([qLab isRunning] == TRUE){
		active = TRUE;
		NSLog(@"Qlab is active"); 
		
	} else {
		
		NSLog(@"Qlab is not active");
		active = FALSE; 
		[self setFeedBackText:@"Please Launch Qlab 2!"]; 
		NSLog(@"Sending Notification"); 
		[nc postNotificationName:(NSString *) JATFeedBackNotification object:self];
	  }
	
	
	
	return active; 
	[qLab release];
}

//Has the workspace been modified?
-(BOOL)isModified 
{
	NSArray *array;
	array = [self getWorkspaceArray];

	int i;
	
	BOOL checkMod = FALSE;
	NSInteger arrayCount = [array count]; 
	
	
	
	
	for (i = 0; i < arrayCount; i++){
		
		checkMod = [[array objectAtIndex:i]modified];
		NSLog(@"checkMod reports %d", checkMod);
		
		if (checkMod == TRUE) {
			NSLog(@"checkMod reports %d", checkMod);
			return TRUE;
		}
		
	}
	
	
	
	return checkMod;
	[array release]; 

}

#pragma mark -
#pragma mark Saving 
#pragma mark -

-(void) saveAllWorkspaces
{
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	NSArray *array;
	array = [self getWorkspaceArray];

	NSArray *document = [self getDocumentArray];
	int i;
	NSInteger arrayCount = [array count]; //Keeps an index of which Workspace the 'for' statment is working with for other methods
	
	
	//Save all workspaces.
	if([self isRunning] == TRUE){
		[self setFeedBackText:@"Qlab is Running Cues: Backup Aborted, Timer Reset"];
		NSLog(@"Sending Notification"); 
		[nc postNotificationName:(NSString *)JATFeedBackNotification object:self];
		
	} else {
		
		
		for (i = 0; i < arrayCount; i++){
			arrayNumber = i;
			workspaceName = [self workspaceNamer];
			[[document objectAtIndex:i]saveIn:(NSURL *)workspaceName as:@"workspace"]; 
		[self moveFiles]; } }
	NSLog(@"BackUps Created");

	[array release];
	[document release];
	
	
}


-(void)saveSpecifiedWorkspace: (int) a 
{
	
	
	NSArray *document = [self getDocumentArray];
	arrayNumber = a;
	workspaceName = [self workspaceNamer];
	
	
	
	[[document objectAtIndex:a]saveIn:(NSURL *)workspaceName as:@"workspace"]; 
	[self moveFiles]; 
	NSLog(@"BackUps Created");
	

	[document release]; 
}


-(void)saveWorkspaceLogic 
{
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; 
	
	//Save Logic 
	NSArray *array = [self getWorkspaceArray];
	NSArray *document = [self getDocumentArray];
	int i;
	NSInteger arrayCount = [array count]; 
	
	
	NSLog(@"Logic Called...");
	
	NSLog(@"Int Value Passed %i", [myPrefs getSaveUnmodifiedBoxState]); 
	
	//If the state of Save unmodified is checked, save all workspaces.
	if ([myPrefs getSaveUnmodifiedBoxState] == 1) {
		[self saveAllWorkspaces]; 
		
	} else { 
		
		//If the state of save unmodified is unchecked, do not save unmodified workspaces.
		
		for (i = 0; i < arrayCount; i++) {	
			if ([[document objectAtIndex:i]modified] == TRUE) {
				
			[self saveSpecifiedWorkspace:i]; }
			
			if ([[document objectAtIndex:i]modified] == FALSE) {
				[self setFeedBackText:@"Workspace Backup Skipped: Unmodified Workspace"]; 
				NSLog(@"Sending Notification"); 
				[nc postNotificationName:(NSString *)JATFeedBackNotification object:self]; }
			
		} }
	

	[array release]; 
	[document release]; 
	
	
}

#pragma mark -
#pragma mark File Handleing / Moving Files Around 
#pragma mark -

// Move Saved workspace to user defined directory.  ScriptingBridge Method saves to Root, this is a work around				
-(void) moveFiles
{ 
	NSString *localPath = @"/"; //Qlab method saves to the root 
	NSString *fileName; 
	NSString *theFileRoot;
	NSString *theFileMove;
	NSString *addCues;
	NSString *saveHere;
	NSString *capturedPath; 
	NSString *incrementString;
	NSString *newFileName;
	NSString *newFileNameCues;
	NSString *newSaveHere;
	
	
	fileName = [self workspaceNamer]; 
	addCues = [fileName stringByAppendingFormat:@".cues"];  //add .cues to filename
	theFileRoot = [localPath stringByAppendingFormat:addCues]; 
	NSLog(@"theFile is here %@", theFileRoot);
	
	theFileMove = [fileName stringByAppendingFormat:@".cues"];
	
	capturedPath = [myPrefs getSavePath];
	NSLog(@"Captured Path is %@", capturedPath);
	saveHere = [capturedPath stringByAppendingFormat:theFileMove];
	NSLog(@"saveHere is %@", saveHere); 
	
	
	fileManager = [NSFileManager defaultManager]; 
	
	if ( [fileManager fileExistsAtPath:theFileRoot] == YES && [fileManager fileExistsAtPath:saveHere] == NO) {
		NSLog(@"Found File"); 
		NSLog(@"Moving File");
	[fileManager movePath:theFileRoot toPath:saveHere handler:nil]; }
	
	//But what if the filename already exisists? Increment the end of the filename
	if ( [fileManager fileExistsAtPath:theFileRoot] == YES && [fileManager fileExistsAtPath:saveHere] == YES) {
		
		incrementString = [NSString stringWithFormat:@"_%d",incrementFileName]; 
		newFileName = [fileName stringByAppendingFormat:incrementString]; 
		NSLog(@"newFileName = %@", newFileName);
		newFileNameCues = [newFileName stringByAppendingFormat:@".cues"]; 
		NSLog(@"NewFileNameCues = %@", newFileNameCues);
		newSaveHere = [capturedPath stringByAppendingFormat:newFileNameCues];
		NSLog(@"NewSaveHere = %@", newSaveHere); 
		
		[fileManager movePath:theFileRoot toPath:newSaveHere handler:nil]; 
		incrementFileName++; 
	}
	
	if ( [fileManager fileExistsAtPath:theFileRoot] == NO) {
	NSLog(@" Did not find file"); }
	
	[localPath release];
	[fileName release]; 
	[theFileRoot release]; 
	[addCues release];
	[saveHere release]; 
	[capturedPath release]; 
	[incrementString release];
	[newFileName release]; 
	[newFileNameCues release]; 
	[newSaveHere release];

	
}


// Create Defualt Name for the Path Save with Time Stamp	
-(id) workspaceNamer
{
	NSString *workspaceZero;
	NSString *addBackup;
	NSString *returnName;
	NSString *nowDate;
	NSDate *now = [NSDate date];
	
	
	// Format the Date String for the file save 
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:[myPrefs getDateString]];
	nowDate = [dateFormatter stringFromDate:now];
	NSLog(@"Now Date is %@", nowDate);
	
	
	//Call the workspaces, get a name and append the string with the Backup and Date Stamps			  
	NSArray *array = [self getWorkspaceArray];
	
	workspaceZero = [[array objectAtIndex:arrayNumber]name];
	addBackup = [[array objectAtIndex:arrayNumber]name];
	
	//Check the user pref boxes for backup and time text options 
	
	if ([myPrefs getBackupCheckBoxState] == 1 && [myPrefs getDateCheckBoxState] == 0) { 

		addBackup = [workspaceZero stringByAppendingString:[myPrefs backUpTextField]];
		returnName = addBackup; } 
	
	if ([myPrefs getBackupCheckBoxState] == 1 && [myPrefs getDateCheckBoxState] == 1) { 
		addBackup = [workspaceZero stringByAppendingString:[myPrefs backUpTextField]];
		returnName = [addBackup stringByAppendingString:nowDate]; }
	
	if ([myPrefs getBackupCheckBoxState] == 0 && [myPrefs getDateCheckBoxState] == 1) { 
	returnName = [workspaceZero stringByAppendingString:nowDate]; }
	
	if ([myPrefs getBackupCheckBoxState] == 0 && [myPrefs getDateCheckBoxState] == 0) { 
		returnName = workspaceZero; }
	
		
	
	NSLog(@"Return Name is %@", returnName);
	
	return returnName;
	
	[workspaceZero release]; 
	[addBackup release]; 
	[returnName release]; 
	[nowDate release]; 
	[now release]; 
	
}


-(int)getArrayNumber
{ 
	int i; 
	i = arrayNumber; 
	
	return i; 
}




#pragma mark -
#pragma mark Workspace Cue Parsing 
#pragma mark - 

-(void) getWorkspaces 
{
	NSArray *array;
	array = [self getWorkspaceArray];
	int i; 
	NSInteger arrayCount = [array count]; 
}




#pragma mark -
#pragma mark Controls 
#pragma mark -

-(void)goCue 
{ 
	
	NSArray *array;
	array = [self getWorkspaceArray];
	
	[[array objectAtIndex:0]go]; 
	
}

-(void)moveSelectionUp
{ 
	NSArray *array;
	array = [self getWorkspaceArray];

	
	[[array objectAtIndex:0]moveSelectionUp];
	
}

-(void)moveSelectionDown 
{ 
	NSArray *array;
	array = [self getWorkspaceArray];
	
	[[array objectAtIndex:0]moveSelectionUp];


}
	

-(void)stopCue
{ 
	NSArray *array;
	array = [self getWorkspaceArray];
	
	[[array objectAtIndex:0]stop];
	
}


-(void)pause 
{ 
	NSArray *array;
	array = [self getWorkspaceArray];
	
	[[array objectAtIndex:0]pause];
	
	
}


-(void)reset 
{ 
	NSArray *array;
	array = [self getWorkspaceArray];

	
	[[array objectAtIndex:0]reset];
	

}



	

		
		

	

@end


