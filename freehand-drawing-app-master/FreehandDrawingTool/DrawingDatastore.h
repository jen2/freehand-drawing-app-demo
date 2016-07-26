//
//  DrawingDatastore.h
//  FreehandDrawingTool
//
//  Created by Jennifer A Sipila on 7/19/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DrawingData.h"

@interface DrawingDatastore : NSObject

+ (DrawingDatastore *) sharedDatastore;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) UIImage *fetchedImage;

- (void)saveContext;
- (void)fetchData;

@end
