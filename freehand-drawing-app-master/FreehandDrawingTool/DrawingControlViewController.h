//
//  DrawingControlViewController.h
//  FreehandDrawingTool
//
//  Created by Jennifer A Sipila on 7/19/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrawViewDelegate <NSObject>

- (void)sliderChanged:(CGFloat)value;
- (void)colorChosen:(UIColor *)color;
- (void)clearButton;
- (void)saveDrawing;

@end

@interface DrawingControlViewController : UIViewController

@property id <DrawViewDelegate> delegate;

@end
