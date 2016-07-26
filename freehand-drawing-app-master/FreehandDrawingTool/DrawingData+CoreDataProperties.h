//
//  DrawingData+CoreDataProperties.h
//  FreehandDrawingTool
//
//  Created by Jennifer A Sipila on 7/19/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DrawingData.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawingData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *drawingImage;

@end

NS_ASSUME_NONNULL_END
