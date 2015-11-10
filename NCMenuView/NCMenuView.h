//
//  NCMenuView.h
//  NCMenuViewDemo
//
//  Created by li naicai on 15/8/26.
//  Copyright (c) 2015年 li naicai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    default_line,
    default_arrow
}lineStyle;
@class SwitchLineView;
typedef void(^ClickBlock)(NSInteger selectIndex);
@interface NCMenuView : UIView
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic)NSInteger currentIndex;
@property(nonatomic)BOOL showLineView;
@property(nonatomic,strong)ClickBlock clickBlock;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic)lineStyle style;
- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)title Complete:(ClickBlock)complete;
- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)title Complete:(ClickBlock)complete ShowLineView:(BOOL)showLineView;
- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)title Complete:(ClickBlock)complete ShowLineView:(BOOL)showLineView LineStyle:(lineStyle)style;
-(void)setCurrentPageAtIndex:(NSInteger)index;
@end

@interface  ArrowView : UIView
- (id)initWithFrame:(CGRect)frame;
@end

@interface LineView : UIView
- (id)initWithFrame:(CGRect)frame;
@end

