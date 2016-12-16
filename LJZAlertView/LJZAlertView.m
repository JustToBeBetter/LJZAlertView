//
//  LJZAlertView.m
//  LJZAlertView
//
//  Created by DBOX on 206/2/2.
//  Copyright © 206年 DBOX. All rights reserved.
//
#import "LJZAlertAppearance.h"
#import "LJZAlertView.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kRect(rect) CGRectMake(rect.origin.x*kWidthRate, rect.origin.y*kWidthRate, rect.size.width*kWidthRate, rect.size.height*kWidthRate)

#define kWidthRate [UIScreen mainScreen].bounds.size.width/375.0
#define selfBacground [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]
#define kHeightRate [UIScreen mainScreen].bounds.size.height/667.0
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]
#define selfGreen [UIColor colorWithRed:69/255.0 green:181/255.0 blue:55/255.0 alpha:0.8]

//屏幕尺寸
#define LJZFullScreen [UIScreen mainScreen].bounds
//AlertViewWidth
#define LJZAlertWidth (LJZFullScreen.size.width - 2 *40)
//按钮默认高度
#define LJZAlertBtnHeight (44)

@interface LJZAlertView ()
/** 配置中心 */
//@property (nonatomic, strong) LJZAlertAppearance* appearance;

@property (nonatomic, strong) UIWindow* window;

@property (nonatomic, strong) UIView* alertView;

@end

@implementation LJZAlertView
{
    
    
    UILabel* _titleLabel;
    UILabel* _messageLabel;
    
    UIButton* _cancelButton;
    UIButton* _commitButton;
    
    UIView* _horizontalLine;
    UIView* _verticalLine;
    
    NSTimeInterval _druation;
    // 标题
    UILabel*_title_label;
    // 内容
    UILabel*_body_label;
}

- (void)show{
    
    [self.window becomeKeyWindow];
    [self.window makeKeyAndVisible];
    [self.window addSubview:self];
    
    [self setShowAnimation];
}
- (void)dismiss{
    
    [self.window resignKeyWindow];
    
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication].delegate.window becomeKeyWindow];
    
    [self removeFromSuperview];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString*)cancelTitle commitButton:(NSString*)commitTitle commitAction:(CommitAction)commitAction druation:(NSTimeInterval)druation{
    
    if (self = [super init]) {
        //        {
        //            //初始化配置
        //            self.appearance = [[LJZAlertAppearance alloc] init];
        //        }
        
        {
            //初始化窗体
            self.window = [[UIWindow alloc] initWithFrame:LJZFullScreen];
            self.window.windowLevel = UIWindowLevelAlert;
        }
        
        {
            //背景区域
            self.backgroundColor = [LJZAlertView appearances].LJZAlertMaskViewColor;
            self.frame = LJZFullScreen;
            self.userInteractionEnabled = YES;
        }
        
        {
            //显示区域
            self.alertView = [[UIView alloc] init];
            self.alertView.backgroundColor = [LJZAlertView appearances].LJZAlertViewColor;
            
            self.alertView.userInteractionEnabled = YES;
            [self addSubview:self.alertView];
        }
        
        {
            //title
            if (title) {
                _titleLabel = [[UILabel alloc] init];
                [self.alertView addSubview:_titleLabel];
                
                _titleLabel.numberOfLines = 0;
                _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:[LJZAlertView appearances].LJZAlertTitleAttributed];
            }
        }
        
        {
            //message
            if (message) {
                _messageLabel = [[UILabel alloc] init];
                
                _messageLabel.numberOfLines = 0;
                _messageLabel.attributedText = [[NSAttributedString alloc] initWithString:message attributes:[LJZAlertView appearances].LJZAlertMessageAttributed];
                [self.alertView addSubview:_messageLabel];
            }
        }
        
        {
            //cancelButton
            if (cancelTitle) {
                _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _cancelButton.backgroundColor = LJZColor(240, 240, 240);
                
                [_cancelButton setAttributedTitle:[[NSAttributedString alloc] initWithString:cancelTitle attributes:[LJZAlertView appearances].LJZAlertCancelTitleAttributed] forState:UIControlStateNormal];
                [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
                [self.alertView addSubview:_cancelButton];
            }
        }
        
        {
            //commitButton
            if (commitTitle) {
                _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _commitButton.backgroundColor = LJZColor(240, 240, 240);
                
                if ([commitTitle isEqualToString:@"删除"]) {
                    [_commitButton setAttributedTitle:[[NSAttributedString alloc] initWithString:commitTitle attributes:[LJZAlertView appearances].LJZAlertCommitTitleAttributed] forState:UIControlStateNormal];
                }else{
                    [_commitButton setAttributedTitle:[[NSAttributedString alloc] initWithString:commitTitle attributes:[LJZAlertView appearances].LJZAlertCustomTitleAttributed] forState:UIControlStateNormal];
                }
                
                [_commitButton handleControlEvent:UIControlEventTouchUpInside withBlock:commitAction];
                [_commitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
                [self.alertView addSubview:_commitButton];
            }
        }
        
        {
            //水平分割线
            if (cancelTitle || commitTitle) {
                _horizontalLine = [[UIView alloc] init];
                _horizontalLine.backgroundColor = [LJZAlertView appearances].horizontalLineColor;
                [self.alertView addSubview:_horizontalLine];
            }
            //垂直分割线
            if (commitTitle) {
                _verticalLine = [[UIView alloc] init];
                _verticalLine.backgroundColor = [LJZAlertView appearances].verticalLineColor;
                [self.alertView addSubview:_verticalLine];
            }
        }
        
        {
            //alertView
            self.alertView.layer.cornerRadius = [LJZAlertView appearances].LJZAlertViewCornerRadius;
            self.alertView.layer.masksToBounds = YES;
        }
        
        {
            //保存变量
            _druation = druation;
        }
    }
    return self;
}

- (void)layoutSubviews{
    
    CGFloat topMargin = [LJZAlertView appearances].LJZAlertViewPadding.top;
    CGFloat leftMargin = [LJZAlertView appearances].LJZAlertViewPadding.left;
    CGFloat rightMargin = [LJZAlertView appearances].LJZAlertViewPadding.right;
    CGFloat height = 0;
    
    if (_titleLabel) {
        CGFloat titleX = leftMargin;
        CGFloat titleY = topMargin;
        CGFloat titleW = LJZAlertWidth - leftMargin - rightMargin;
        CGFloat titleH = _titleLabel.frame.size.height;
        _titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
        [_titleLabel sizeToFit];
        _titleLabel.center = CGPointMake(LJZAlertWidth / 2, _titleLabel.center.y);
        
        height = CGRectGetMaxY(_titleLabel.frame) + 30;
        
    }
    
    if (_messageLabel) {
        CGFloat messageX = leftMargin;
        CGFloat messageY = CGRectGetMaxY(_titleLabel.frame) + [LJZAlertView appearances].LJZAlertMessageTopMargin;
        CGFloat messageW = LJZAlertWidth - leftMargin - rightMargin;
        CGFloat messageH = _messageLabel.frame.size.height;
        _messageLabel.frame = CGRectMake(messageX, messageY, messageW, messageH);
        [_messageLabel sizeToFit];
        _messageLabel.center = CGPointMake(LJZAlertWidth / 2, _messageLabel.center.y);
        
        height = CGRectGetMaxY(_messageLabel.frame) + 30;
    }
    
    if (_cancelButton && (!_commitButton)) {
        CGFloat cancelBtnX = 0;
        CGFloat cancelBtnY = height;
        CGFloat cancelBtnW = LJZAlertWidth;
        CGFloat cancelBtnH = LJZAlertBtnHeight;
        _cancelButton.frame = CGRectMake(cancelBtnX, cancelBtnY, cancelBtnW, cancelBtnH);
    }
    
    if ((!_cancelButton) && _commitButton) {
        CGFloat commitBtnX = 0;
        CGFloat commitBtnY = height;
        CGFloat commitBtnW = LJZAlertWidth;
        CGFloat commitBtnH = LJZAlertBtnHeight;
        _commitButton.frame = CGRectMake(commitBtnX, commitBtnY, commitBtnW, commitBtnH);
    }
    
    if (_cancelButton && _commitButton) {
        
        CGFloat cancelBtnX = 0;
        CGFloat cancelBtnY = height;
        CGFloat cancelBtnW = LJZAlertWidth / 2;
        CGFloat cancelBtnH = LJZAlertBtnHeight;
        _cancelButton.frame = CGRectMake(cancelBtnX, cancelBtnY, cancelBtnW, cancelBtnH);
        
        CGFloat commitBtnX = cancelBtnW;
        CGFloat commitBtnY = cancelBtnY;
        CGFloat commitBtnW = cancelBtnW;
        CGFloat commitBtnH = LJZAlertBtnHeight;
        _commitButton.frame = CGRectMake(commitBtnX, commitBtnY, commitBtnW, commitBtnH);
        
        CGFloat verticalX = cancelBtnW;
        CGFloat verticalY = height + 3;
        CGFloat verticalW = 0.5;
        CGFloat verticalH = LJZAlertBtnHeight - 26;
        _verticalLine.frame = CGRectMake(verticalX, verticalY, verticalW, verticalH);
    }
    
    if (_cancelButton || _commitButton) {
        CGFloat horizontalX = 0;
        CGFloat horizontalY = height;
        CGFloat horizontalW = LJZAlertWidth;
        CGFloat horizontalH = 0.5;
        _horizontalLine.frame = CGRectMake(horizontalX, horizontalY, horizontalW, horizontalH);
        
        height += LJZAlertBtnHeight;
    }
    
    self.alertView.frame = CGRectMake(0, 0, LJZAlertWidth, height);
    self.alertView.center = self.center;
    
}

+ (LJZAlertAppearance *)appearances{
    
    static LJZAlertAppearance* appearance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = [[LJZAlertAppearance alloc] init];
    });
    
    return appearance;
}

- (void)setShowAnimation{
    switch ([LJZAlertView appearances].LJZAlertAnimationStyle) {
        case LJZAlertAnimationStyleDefault:
        {
            CGPoint startPoint = CGPointMake(self.center.x, -_alertView.frame.size.height);
            _alertView.layer.position=startPoint;
            
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
                if (_druation) {
                    [UIView animateWithDuration:.25 delay:_druation options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.alpha = 0;
                    } completion:^(BOOL finished) {
                        [self dismiss];
                    }];
                }
            }];
        }
            break;
    }
}

+ (void)showWithTitle:(NSString*)title message:(NSString*)message druation:(NSTimeInterval)druation{
    
    LJZAlertView* alertView = [[LJZAlertView alloc] initWithTitle:title message:message cancelButton:nil commitButton:nil commitAction:NULL druation:druation];
    
    [alertView show];
    
}


+ (void)showWithTitle:(NSString*)title message:(NSString*)message cancelButton:(NSString*)cancelTitle{
    
    LJZAlertView* alertView = [[LJZAlertView alloc] initWithTitle:title message:message cancelButton:cancelTitle commitButton:nil commitAction:NULL  druation:0];
    
    [alertView show];
}

+ (void)showWithTitle:(NSString*)title message:(NSString*)message cancelButton:(NSString*)cancelTitle customButton:(NSString*)commitTitle commitAction:(CommitAction)commitAction{
    
    LJZAlertView* alertView = [[LJZAlertView alloc] initWithTitle:title message:message cancelButton:cancelTitle commitButton:commitTitle commitAction:commitAction druation:0];
    
    [alertView show];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelTitle commitType:(LJZAlertViewButtonType )type commitAction:(CommitAction)commitAction{
    
    NSString* commitTitle = (type == 0)?@"确定":@"删除";
    
    LJZAlertView* alertView = [[LJZAlertView alloc] initWithTitle:title message:message cancelButton:cancelTitle commitButton:commitTitle commitAction:commitAction druation:0];
    
    [alertView show];
}

#pragma
#pragma  mark =================second=================
-(instancetype)init{
    
    self=[super init];
    
    if (self) {
        
        // self.frame=CGRectMake(0,kScreenWith,kScreenHeight,kScreenHeight-64);
        
    }
    
    return self;
}

-(void)createUI:(NSString *)cancel otherTitle:(NSString*)other{
    
    UIView * white_view=[[UIView alloc]initWithFrame:kRect(CGRectMake(50, 220, 275, 190))];
    white_view.backgroundColor=[UIColor whiteColor];
    white_view.layer.cornerRadius=10;
    [self addSubview:white_view];
    
    //  title
    _title_label = [[UILabel alloc]initWithFrame:kRect(CGRectMake(10,15,255, 30))];
    _title_label.textColor = UIColorFromRGB(0x383838);
    _title_label.textAlignment = NSTextAlignmentCenter;
    [white_view addSubview:_title_label];
    //  body
    _body_label=[[UILabel alloc]initWithFrame:kRect(CGRectMake(10,55,255,60))];
    _body_label.font=[UIFont systemFontOfSize:14];
    _body_label.textAlignment=NSTextAlignmentCenter;
    _body_label.textColor=UIColorFromRGB(0x717171);
    //  换行最多两行
    _body_label.numberOfLines=2;
    [white_view addSubview:_body_label];
    
    //  分割线
    
    UILabel * fen_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 150*kHeightRate, 275*kWidthRate, 1)];
    fen_label.backgroundColor=selfBacground;
    [white_view addSubview:fen_label];
    
    
    if (cancel.length&&other.length) {
        //  取消和确认按钮存在(两个按钮存在)
        
        for (int i=0; i<2;i++) {
            
            UIButton * button = [[UIButton alloc]initWithFrame:kRect(CGRectMake((275/2)*i,150, (275/2), 40))];
            
            [white_view addSubview:button];
            
            UILabel * gray_line = [[UILabel alloc]initWithFrame:kRect(CGRectMake((275/2), 150, 1, 40))];
            
            gray_line.backgroundColor = selfBacground;
            
            [white_view addSubview:gray_line];
            
            if (i==0) {
                
                [button setTitle:@"取消" forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
                
                [button setTitleColor:selfGreen forState:UIControlStateNormal];
                
            }
            else if (i==1){
                
                [button setTitle:@"确定" forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
                
                [button setTitleColor:selfGreen forState:UIControlStateNormal];
                
            }
        }
    }else if (([cancel isEqual:nil]||[cancel isEqualToString:@""])||([other isEqual:nil]||[other isEqualToString:@""])){
        
        // 取消按钮为空和确定按钮为空(无按钮情况)
        
        fen_label.hidden=YES;
        
        white_view.frame=kRect(CGRectMake(50, 220,375-100, 150));
        
    }else if (cancel.length){
        
        //有一个确认按钮(一个按)没有网络请求相当于取消(虽是确认但是是取消）
        UIButton * button = [[UIButton alloc]initWithFrame:kRect(CGRectMake(0,150,275, 40))];
        
        [white_view addSubview:button];
        
        UILabel * gray_line = [[UILabel alloc]initWithFrame:kRect(CGRectMake((275/2), 150, 1, 40))];
        
        gray_line.backgroundColor = selfBacground;
        
        //[white_view addSubview:gray_line];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:selfGreen forState:UIControlStateNormal];
        
    }
    
}
//取消
- (void)cancel{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self removeFromSuperview];
        
    } completion:^(BOOL finished) {
        
    }];
    
}
//确认
- (void)sure{
    
        if (_delegate &&[_delegate respondsToSelector:@selector(LJZClickedButtonAtIndex:)]) {
    
            [_delegate LJZClickedButtonAtIndex:1];
        }
}
//警告框显示
-(void)showAlert{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        UIWindow * window=[UIApplication sharedApplication].keyWindow;
        
        [window addSubview:self];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message deleagte:(id)delegate cancelButton:(NSString *)cancel otherbuttonTitle:(NSString *)other{
    //    代理方法
        _delegate=delegate;
        //    创建UI
        [self createUI:cancel otherTitle:other];
        //    传值
        _body_label.text=message;
    
        _title_label.text=title;
}


@end


@implementation UIButton (block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(CommitAction)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)callActionBlock:(id)sender {
    CommitAction block = (CommitAction)objc_getAssociatedObject(self, &overviewKey);
    
    if (block) {
        __weak typeof(self) weakSelf = self;
        block(weakSelf);
    }
}


@end
