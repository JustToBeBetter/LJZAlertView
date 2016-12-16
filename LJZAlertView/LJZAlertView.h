//
//  LJZAlertView.h
//  LJZAlertView
//
//  Created by DBOX on 2016/12/12.
//  Copyright © 2016年 DBOX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, LJZAlertViewButtonType) {
    LJZAlertViewButtonCommit = 0,
    LJZAlertViewButtonDelete,
};
typedef void(^CommitAction)(UIButton* button);

@class LJZAlertAppearance;

@protocol LJZAlertViewDelegate <NSObject>

@required

-(void)LJZClickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface LJZAlertView : UIView

+ (LJZAlertAppearance *)appearances;

/** 标题, 消息,自动消失*/
+ (void)showWithTitle:(NSString*)title message:(NSString*)message druation:(NSTimeInterval)druation;

/** 标题, 消息,取消按钮*/
+ (void)showWithTitle:(NSString*)title message:(NSString*)message cancelButton:(NSString*)cancelTitle;

/** 标题, 消息,取消按钮,确定按钮*/
+ (void)showWithTitle:(NSString*)title message:(NSString*)message cancelButton:(NSString*)cancelTitle customButton:(NSString*)commitTitle commitAction:(CommitAction)commitAction;

/** 标题, 消息,取消按钮,确定按钮(给定默认按钮样式)*/
+ (void)showWithTitle:(NSString*)title message:(NSString*)message cancelButton:(NSString*)cancelTitle commitType:(LJZAlertViewButtonType)type commitAction:(CommitAction)commitAction;

//
@property(nonatomic,weak)__weak id<LJZAlertViewDelegate>delegate;
//警告框标题
@property(nonatomic,copy) NSString *title;
//警告框内容
@property(nonatomic,copy) NSString *body;
//警告框显示
- (void)showAlert;

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message deleagte:(id)delegate cancelButton:(NSString *)cancel otherbuttonTitle:(NSString *)other;

@end


@interface UIButton (block)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(CommitAction)action;

@end
