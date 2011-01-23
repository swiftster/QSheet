//
//  ImportOp.h
//  QServer
//
//  Created by Jason Tratta on 9/5/09.
//  Copyright 2009 Sound Character All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyDocument.h"
#import "QlabScripting.h"
#import "Qlab.h"
@class QServer_AppDelegate;


@interface ImportOp : NSOperation {
	
	MyDocument *appDelegate;
	NSManagedObjectContext *mainMOC;
	int sortInt;
	

}


@property (assign) MyDocument *appDelegate;
@property (readwrite, assign) NSManagedObjectContext *mainMOC; 
@property (readwrite, assign) int sortInt;

- (id)initWithDelegate:(MyDocument*)aDelegate;
- (NSManagedObjectContext*)newContextToMainStore;
- (void)contextDidSave:(NSNotification*)notification;


-(NSManagedObject *)cueObject:(int) c:(NSManagedObjectContext *) moc:(NSArray *)cueArray;
-(NSManagedObject *)groupObject:(int) c:(NSManagedObjectContext *) moc: (NSArray *)cueArray;

-(NSString *)doubleToString:(NSNumber *)numberToString;
-(int)incrementSortInt;





@end
