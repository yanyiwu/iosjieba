//
//  ViewController.m
//  iosjieba
//
//  Created by yanyiwu on 14/12/23.
//  Copyright (c) 2014年 yanyiwu. All rights reserved.
//

#import "ViewController.h"
#include "Segmentor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect bounds = self.view.bounds;
    
    // label
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    label.text = @"结巴中文分词";
    label.tag = 100;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds) * 1 / 4);
    [self.view addSubview:label];
    
    
    CGRect textViewFrame = CGRectMake(0.0f, 0.0f, 300.0f, 100.0f);
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    
    textView.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds) * 1 / 2);
    textView.returnKeyType = UIReturnKeyDone;
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    [self.view addSubview:textView];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    NSString *dictPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"iosjieba.bundle/dict/jieba.dict.small.utf8"];
    NSString *hmmPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"iosjieba.bundle/dict/hmm_model.utf8"];
    NSString *userDictPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"iosjieba.bundle/dict/user.dict.utf8"];
    
    NSLog(@"%@",dictPath);
    NSLog(@"%@",hmmPath);
    NSLog(@"%@",hmmPath);
    
    const char *cDictPath = [dictPath UTF8String];
    const char *cHmmPath = [hmmPath UTF8String];
    const char *cUserDictPath = [userDictPath UTF8String];
    
    
    JiebaInit(cDictPath, cHmmPath, cUserDictPath);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)becomeFirstResponder {
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    //textView.backgroundColor = [UIColor greenColor];
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
    //textView.backgroundColor = [UIColor whiteColor];
    const char* sentence = [textView.text UTF8String];
    std::vector<std::string> words;
    JiebaCut(sentence, words);
    std::string result;
    result << words;
    textView.text = [NSString stringWithUTF8String:result.c_str()] ;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing:");
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"textViewDidChange:");
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    NSLog(@"textViewDidChangeSelection:");
}

@end

