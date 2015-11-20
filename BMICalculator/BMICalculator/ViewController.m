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
    
    //change input fields border color
    _weightField.layer.borderColor=[[UIColor colorWithRed:127.0f/255.0f green:140.0f/255.0f blue:141.0f/255.0f alpha:1.0] CGColor];
    _weightField.layer.borderWidth=1.0;
    _heightField.layer.borderColor=[[UIColor colorWithRed:127.0f/255.0f green:140.0f/255.0f blue:141.0f/255.0f alpha:1.0] CGColor];
    _heightField.layer.borderWidth=1.0;
    
    //instantiate number formatter for input fields
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
    //delegate input field formatting
    _weightField.delegate = self;
    _heightField.delegate = self;
}

//set focus on weight field
- (void)viewWillAppear:(BOOL)animated {
    [self.weightField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //call result view, passing weight and height
    ResultViewController *destViewController = segue.destinationViewController;
    destViewController.weight = [self.weightField.text floatValue];
    destViewController.height = [self.heightField.text floatValue];
 }

//validate input fields before segue
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)segue sender:(id)sender {
    //validate user input before segue
    if([self.weightField.text floatValue]>0 && [self.heightField.text floatValue]>0){
        return YES; // check successful; perform segue
    }else{
        NSString *errorMessage = @"Please, inform a valid weight and height!";
        self.errorLabel.text = errorMessage;
    }
    return NO;
}

//input formatting callback, as per https://github.com/peterboni/FormattedCurrencyInput
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSInteger MAX_DIGITS = 5; // 999.99
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
    NSString *stringMaybeChanged = [NSString stringWithString:string];
    if (stringMaybeChanged.length > 1)
    {
        NSMutableString *stringPasted = [NSMutableString stringWithString:stringMaybeChanged];
       
        [stringPasted replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [stringPasted length])];
        
        NSDecimalNumber *numberPasted = [NSDecimalNumber decimalNumberWithString:stringPasted];
        stringMaybeChanged = [numberFormatter stringFromNumber:numberPasted];
    }
    
    UITextRange *selectedRange = [textField selectedTextRange];
    UITextPosition *start = textField.beginningOfDocument;
    NSInteger cursorOffset = [textField offsetFromPosition:start toPosition:selectedRange.start];
    NSMutableString *textFieldTextStr = [NSMutableString stringWithString:textField.text];
    NSUInteger textFieldTextStrLength = textFieldTextStr.length;
    
    [textFieldTextStr replaceCharactersInRange:range withString:stringMaybeChanged];
    
    [textFieldTextStr replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [textFieldTextStr length])];
    
    [textFieldTextStr replaceOccurrencesOfString:numberFormatter.decimalSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [textFieldTextStr length])];
    
    if (textFieldTextStr.length <= MAX_DIGITS)
    {
        NSDecimalNumber *textFieldTextNum = [NSDecimalNumber decimalNumberWithString:textFieldTextStr];
        NSDecimalNumber *divideByNum = [[[NSDecimalNumber alloc] initWithInt:10] decimalNumberByRaisingToPower:numberFormatter.maximumFractionDigits];
        NSDecimalNumber *textFieldTextNewNum = [textFieldTextNum decimalNumberByDividingBy:divideByNum];
        NSString *textFieldTextNewStr = [numberFormatter stringFromNumber:textFieldTextNewNum];
        
        textField.text = textFieldTextNewStr;
        
        if (cursorOffset != textFieldTextStrLength)
        {
            NSInteger lengthDelta = textFieldTextNewStr.length - textFieldTextStrLength;
            NSInteger newCursorOffset = MAX(0, MIN(textFieldTextNewStr.length, cursorOffset + lengthDelta));
            UITextPosition* newPosition = [textField positionFromPosition:textField.beginningOfDocument offset:newCursorOffset];
            UITextRange* newRange = [textField textRangeFromPosition:newPosition toPosition:newPosition];
            [textField setSelectedTextRange:newRange];
        }
    }
    
    return NO;
}

@end
