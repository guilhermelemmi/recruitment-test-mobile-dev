//
//  ResultViewController.m
//  BMICalculator
//
//  Created by Teste IOS on 11/19/15.
//  Copyright © 2015 Teste IOS. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //calculate bmi
    _bmi = _weight / (_height * _height);
    
    NSString *bmiLabel;
    UIColor *green = [UIColor colorWithRed:22/255.0 green:160/255.0 blue:133/255.0 alpha:1.0];
    UIColor *yellow = [UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:1.0];
    UIColor *orange = [UIColor colorWithRed:230/255.0 green:126/255.0 blue:34/255.0 alpha:1.0];
    UIColor *red = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1.0];
    UIColor *boxColor = green;
    
    //get bmi classification label
    if (_bmi < 15){
        bmiLabel = @"Very Severely\nUnderweight";
        boxColor = red;
    }else if (_bmi < 16){
        bmiLabel = @"Severely\nUnderweight";
        boxColor = orange;
    }else if( _bmi < 18.5) {
        bmiLabel = @"Underweight";
        boxColor = yellow;
    }else if (_bmi < 25.0) {
        bmiLabel = @"Normal";
    }else if (_bmi < 30.0) {
        bmiLabel = @"Overweight";
        boxColor = yellow;
    }else if (_bmi < 35.0) {
        bmiLabel = @"Moderately\nObese";
        boxColor = orange;
    }else if (_bmi < 40.0) {
        bmiLabel = @"Severely\nObese";
        boxColor = red;
    }else {
        bmiLabel = @"Very Severely\nObese";
        boxColor = red;
    }
    
    //format BMI with two decimal plates
    _formatter = [[NSNumberFormatter alloc] init];
    [_formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [_formatter setMaximumFractionDigits:2];
    
    //show values on screen
    _bmiValue.text = [_formatter stringFromNumber:@(_bmi)];
    _bmiClassification.text= bmiLabel;
    _resultBox.backgroundColor = boxColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
