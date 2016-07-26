//
//  DrawingControlViewController.m
//  FreehandDrawingTool
//
//  Created by Jennifer A Sipila on 7/19/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

#import "DrawingControlViewController.h"
#import "DrawingAreaView.h"

@interface DrawingControlViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet DrawingAreaView *lineView;

@end

@implementation DrawingControlViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self.lineView;
    self.slider.minimumValue = 3.0;
    self.slider.maximumValue = 15.0;
}

#pragma mark DrawViewControllerDelegate Methods

- (IBAction)valueChangedOnSLider:(UISlider *)sender
{
    [self.delegate sliderChanged:sender.value];
}

- (IBAction)colorButtonTapped:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Erase"]) {
        [self.delegate colorChosen:[UIColor whiteColor]];
    } else {
        [self.delegate colorChosen:sender.backgroundColor];
    }
}

- (IBAction)clearButtonTapped:(UIButton *)sender
{
    [self.delegate clearButton];
}

@end
