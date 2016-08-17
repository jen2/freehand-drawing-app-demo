//
//  DrawingAreaView.m
//  FreehandDrawingTool
//
//  Created by Jennifer A Sipila on 7/19/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

#import "DrawingAreaView.h"

@interface DrawingAreaView ()

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIImage *incrementalImage;
@property (nonatomic, assign) NSUInteger ctr;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) NSUInteger sliderLineWidth;
@property (nonatomic, weak) IBOutlet UISlider *sliderOutlet;

@end

@implementation DrawingAreaView
{
    CGPoint pts[5];
}

#pragma mark Initializations

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.path = [UIBezierPath bezierPath];
        NSUInteger defaultLineWidth = 3.0;
        [self.path setLineWidth:defaultLineWidth];
        self.sliderLineWidth = 3.0;
        self.lineColor = [UIColor blackColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMultipleTouchEnabled:NO];
        self.path = [UIBezierPath bezierPath];
        NSUInteger defaultLineWidth = 3.0;
        //Set slider position to default
        [self.path setLineWidth:defaultLineWidth];
    }
    return self;
}

#pragma mark Actions

- (void)drawRect:(CGRect)rect
{
    [self.incrementalImage drawInRect:rect];
    [self.lineColor setStroke];
    [self.path stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.ctr = 0;
    UITouch *touch = [touches anyObject];
    pts[0] = [touch locationInView:self];
    self.path.lineWidth = self.sliderLineWidth;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches moved");
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    self.ctr++;
    pts[self.ctr] = p;
    if (self.ctr == 4) {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0);
        [self.path moveToPoint:pts[0]];
        [self.path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]];
        [self setNeedsDisplay];
        pts[0] = pts[3];
        pts[1] = pts[4];
        self.ctr = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches ended");
    [self drawBitmap];
    [self setNeedsDisplay];
    [self.path removeAllPoints];
    self.ctr = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark UIBezierPath Caching

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    if (!self.incrementalImage) {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [rectpath fill];
    }
    [self.incrementalImage drawAtPoint:CGPointZero];
    [self.lineColor setStroke];
    [self.path stroke];
    self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

#pragma mark DrawingViewDelegate

- (void)clearButton
{
    self.path = nil;
    self.path = [UIBezierPath bezierPath];
    self.incrementalImage = nil;
    [self setNeedsDisplay];
}

- (void)sliderChanged:(CGFloat)value
{
    self.sliderLineWidth = value;
}

- (void)colorChosen:(UIColor *)color
{
    self.lineColor = color;
}

@end
