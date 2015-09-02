//
//  NCMenuView.h
//  NCMenuViewDemo
//
//  Created by li naicai on 15/8/26.
//  Copyright (c) 2015年 li naicai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchLineView;
typedef void(^ClickBlock)(NSInteger selectIndex);
@interface NCMenuView : UIView
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic)NSInteger currentIndex;
@property(nonatomic,strong)ClickBlock clickBlock;
@property(nonatomic,strong)SwitchLineView *lineView;
- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)title Complete:(ClickBlock)complete;
-(void)setCurrentPageAtIndex:(NSInteger)index;
@end

@interface SwitchLineView : UIView
- (id)initWithFrame:(CGRect)frame;
@end
