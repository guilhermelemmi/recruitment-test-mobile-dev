//
//  ViewController.m
//  BMICalculator
//
//  Created by Teste IOS on 11/19/15.
//  Copyright © 2015 Teste IOS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _formatter = [[NSNumberFormatter alloc] init];
    [_formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [_formatter setMaximumFractionDigits:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateBMIButton:(id)sender {
        float bmi = [_weightField.text floatValue] / ([_heightField.text floatValue]*[_heightField.text floatValue]);
        NSString *bmiLabel;
        
        if (bmi < 18.5) {
            bmiLabel = @"Underweight";
        }else if (bmi < 25.0) {
            bmiLabel = @"Normal";
        }else if (bmi < 30.0) {
            bmiLabel = @"Overweight";
        }else {
            bmiLabel = @"Obese";
        }
        
        _resultText.text=[NSString stringWithFormat:@"Your BMI is: %@ - %@", [_formatter stringFromNumber:@(bmi)], bmiLabel];

}
@end
