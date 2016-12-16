//
//  LJZAlertAppearance.m
//  LJZAlertView
//
//  Created by DBOX on 2016/12/12.
//  Copyright © 2016年 DBOX. All rights reserved.
//

#import "LJZAlertAppearance.h"

@implementation LJZAlertAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /** alertView*/
        self.LJZAlertMaskViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.LJZAlertViewPadding = UIEdgeInsetsMake(30, 20, 30, 20);
        self.LJZAlertViewColor = [UIColor whiteColor];
        self.LJZAlertViewCornerRadius = 4.;
        
        /** title*/
        NSMutableParagraphStyle* titleStyle = [[NSMutableParagraphStyle alloc] init];
        titleStyle.lineSpacing = 5;
        titleStyle.alignment = NSTextAlignmentCenter;
        
        self.LJZAlertTitleAttributed = @{
                                        NSFontAttributeName:[UIFont systemFontOfSize:17],
                                        NSForegroundColorAttributeName:LJZColor(45, 43, 51),
                                        NSParagraphStyleAttributeName:titleStyle,
                                        };
        
        /** message1*/
        NSMutableParagraphStyle* message1Style = [[NSMutableParagraphStyle alloc] init];
        message1Style.lineSpacing = 5;
        message1Style.alignment = NSTextAlignmentCenter;
        
        self.LJZAlertMessageAttributed = @{
                                           NSFontAttributeName:[UIFont systemFontOfSize:17],
                                           NSForegroundColorAttributeName:LJZColor(155, 155, 155),
                                           NSParagraphStyleAttributeName:message1Style
                                           };
        self.LJZAlertMessageTopMargin  = 15.;
        
        /** line*/
        self.horizontalLineColor = [UIColor clearColor];
        self.verticalLineColor = LJZColor(159,157,166);
        
        /** cancelTitle*/
        self.LJZAlertCancelTitleAttributed = @{
                                              NSFontAttributeName:[UIFont systemFontOfSize:17],
                                              NSForegroundColorAttributeName:LJZColor(159,157,166)
                                              };
        
        /** customTitle*/
        self.LJZAlertCustomTitleAttributed = @{
                                              NSFontAttributeName:[UIFont systemFontOfSize:17],
                                              NSForegroundColorAttributeName:LJZColor(0, 145, 255)
                                              };
        
        /** deleteTitle*/
        self.LJZAlertCommitTitleAttributed = @{
                                              NSFontAttributeName:[UIFont systemFontOfSize:17],
                                              NSForegroundColorAttributeName:LJZColor(255, 100, 0)
                                              };
        /** Animation*/
        self.LJZAlertAnimationStyle = LJZAlertAnimationStyleDefault;
        
    }
    return self;
}


@end
