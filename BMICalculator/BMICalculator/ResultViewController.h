//
//  ResultViewController.h
//  BMICalculator
//
//  Created by Teste IOS on 11/19/15.
//  Copyright © 2015 Teste IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *resultBox;
@property (strong, nonatomic) IBOutlet UILabel *bmiValue;
@property (strong, nonatomic) IBOutlet UILabel *bmiClassification;

@property float weight;
@property float height;
@property float bmi;

@property (strong, nonatomic) NSNumberFormatter *formatter;

@end
