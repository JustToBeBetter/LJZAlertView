//
//  ViewController.m
//  LJZAlertView
//
//  Created by DBOX on 2016/12/12.
//  Copyright © 2016年 DBOX. All rights reserved.
//

#import "ViewController.h"
#import "LJZAlertView.h"

@interface ViewController ()<LJZAlertViewDelegate>
- (IBAction)show1:(UIButton *)sender;
- (IBAction)show2:(id)sender;
- (IBAction)show3:(id)sender;
- (IBAction)show4:(id)sender;
- (IBAction)show5:(id)sender;
- (IBAction)show6:(id)sender;
- (IBAction)show7:(id)sender;

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


- (IBAction)show1:(UIButton *)sender {
    
    
    [LJZAlertView showWithTitle:@"我是标题,我可以为空" message:@"我是消息,我也可以为空" cancelButton:@"取消" customButton:@"确定" commitAction:^(UIButton *button) {
        NSLog(@"确定");
    }];
   // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"12342234" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}

- (IBAction)show2:(id)sender {
    [LJZAlertView showWithTitle:@"不要看着我" message:@"我会自动消失的" druation:1];
}

- (IBAction)show3:(id)sender {
    [LJZAlertView showWithTitle:@"1234" message:nil cancelButton:@"取消"];
}

- (IBAction)show4:(id)sender {
    [LJZAlertView showWithTitle:@"686" message:@"0000" cancelButton:@"取消" commitType:LJZAlertViewButtonCommit commitAction:^(UIButton *button) {
        NSLog(@"滴滴");
    }];
}

- (IBAction)show5:(id)sender {
    LJZAlertView *alert = [[LJZAlertView alloc]init];
   alert.frame=CGRectMake(0,0,375,1134-64);
    
    alert.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    [alert showAlertViewWithTitle:@"你愁啥" message:@"瞅你咋地" deleagte:self cancelButton:@"再愁一个试试" otherbuttonTitle:@"试试就试试"];
    
    [alert showAlert];
}

- (IBAction)show6:(id)sender {
    LJZAlertView *alert = [[LJZAlertView alloc]init];
    alert.frame=CGRectMake(0,0,375,1134-64);
    
    alert.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [alert showAlertViewWithTitle:@"你愁啥" message:@"瞅你咋地" deleagte:self cancelButton:@"再愁一个试试" otherbuttonTitle:nil];
    
    [alert showAlert];
}

- (IBAction)show7:(id)sender {
    LJZAlertView *alert = [[LJZAlertView alloc]init];
    alert.frame=CGRectMake(0,0,375,1134-64);
    
    alert.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
     [self performSelector:@selector(Time:) withObject:alert afterDelay:1];
    [alert showAlertViewWithTitle:@"你愁啥" message:@"瞅你咋地" deleagte:self cancelButton:@"" otherbuttonTitle:@""];
    
    [alert showAlert];
}
-(void)Time:(LJZAlertView *)view{
    
    [view removeFromSuperview];
    
}
- (void)LJZClickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSLog(@"确定");
    }
}
@end
