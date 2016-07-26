//
//  DrawingDatastore.m
//  FreehandDrawingTool
//
//  Created by Jennifer A Sipila on 7/19/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

#import "DrawingDatastore.h"
#import <UIKit/UIKit.h>

@implementation DrawingDatastore

#pragma mark Datastore Initialization

+ (DrawingDatastore *)sharedDatastore
{
    static DrawingDatastore *shareddatastoreInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareddatastoreInstance = [[DrawingDatastore alloc] init];
    });
    return shareddatastoreInstance;
}

#pragma mark Save And Fetch Methods

- (void) saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)fetchData
{
    NSFetchRequest *fetchAllImages = [NSFetchRequest fetchRequestWithEntityName:@"BezierData"];
    DrawingDatastore *datastore = [DrawingDatastore sharedDatastore];
    //    self.images = [datastore.managedObjectContext executeFetchRequest:fetchAllImages  error: nil];
    NSArray *fetchedItems = [datastore.managedObjectContext executeFetchRequest:fetchAllImages  error: nil];
    //    self.fetchedImage
    
    for (NSData *item in fetchedItems) {
        self.fetchedImage = [UIImage imageWithData:item];
        [self.images addObject: self.fetchedImage];
    }
    
    //create sort descriptor THEN make the .sortDescriptors property of this fetchAllMessages equal to it.
    // fetchAllMessages.sortDescriptors = @[ // put sort descriptor in here ];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DrawingData.sqlite"];
    NSError *error = nil;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"drawApp" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
