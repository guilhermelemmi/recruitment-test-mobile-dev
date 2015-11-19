//
//  ViewController.m
//  BMICalculator
//
//  Created by Teste IOS on 11/19/15.
//  Copyright © 2015 Teste IOS. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {    
     ResultViewController *destViewController = segue.destinationViewController;
     destViewController.weight = [_weightField.text floatValue];
     destViewController.height = [_heightField.text floatValue];
 }


@end
