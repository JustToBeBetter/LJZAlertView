//
//  LJZAlertAppearance.h
//  LJZAlertView
//
//  Created by DBOX on 206/2/2.
//  Copyright © 206年 DBOX. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define LJZColor(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

typedef NS_ENUM(NSUInteger, LJZAlertAnimationStyles) {
    LJZAlertAnimationStyleDefault,
};


@interface LJZAlertAppearance : NSObject
/** alertView*/
@property (nonatomic,strong) UIColor* LJZAlertMaskViewColor;
@property (nonatomic,strong) UIColor* LJZAlertViewColor;
@property (nonatomic, assign) UIEdgeInsets LJZAlertViewPadding;
@property (nonatomic,assign) CGFloat LJZAlertViewCornerRadius;

/** title*/
@property (nonatomic,strong) NSDictionary<NSString *, id> * LJZAlertTitleAttributed;

/** message*/
@property (nonatomic,assign) CGFloat LJZAlertMessageTopMargin;
@property (nonatomic,strong) NSDictionary<NSString *, id> * LJZAlertMessageAttributed;

/** cancelTitle*/
@property (nonatomic,assign) CGFloat LJZAlertCancelTitleTopMargin;
@property (nonatomic,strong) NSDictionary<NSString *, id> * LJZAlertCancelTitleAttributed;

/** customButton*/
@property (nonatomic,strong) NSDictionary<NSString *, id> * LJZAlertCustomTitleAttributed;

///** commitButton*/
@property (nonatomic,strong) NSDictionary<NSString *, id> * LJZAlertCommitTitleAttributed;
//
///** deleteButton*/
//@property (nonatomic,strong) NSDictionary<NSString *, id> * LJZAlertDeleteTitleAttributed;


/** line*/
@property (nonatomic,strong) UIColor* horizontalLineColor;
@property (nonatomic,strong) UIColor* verticalLineColor;

/** Animation*/
@property (nonatomic, assign) LJZAlertAnimationStyles LJZAlertAnimationStyle;


@end
