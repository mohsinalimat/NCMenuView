//
//  NCMenuView.m
//  NCMenuViewDemo
//
//  Created by li naicai on 15/8/26.
//  Copyright (c) 2015年 li naicai. All rights reserved.
//

#import "NCMenuView.h"
#define line_h 37
#define arrow_h 15
@implementation NCMenuView

- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)title Complete:(ClickBlock)complete
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clickBlock=[complete copy];
        self.titles=[title copy];
        self.currentIndex=0;
        [self setBackgroundColor:[UIColor clearColor]];
        [self initControl];
        [self setClipsToBounds:NO];
    }
    return self;
}
-(void)initControl{
    CGRect rect=self.bounds;
    rect.size.width*=self.titles.count;
    self.lineView=[[SwitchLineView alloc]initWithFrame:rect];
    [self.lineView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.lineView];
    
    self.buttons=[NSMutableArray array];
    for (id title in self.titles) {
        NSInteger i=[self.titles indexOfObject:title];
        NSInteger with=self.bounds.size.width/self.titles.count;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button setFrame:CGRectMake(with*i, 0, with, line_h)];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setTag:i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (button.tag==self.currentIndex) {
            [button setSelected:YES];
            CGPoint point=self.lineView.center;
            
            point.x=button.center.x;
            [self.lineView setCenter:point];
        }
        else{
            [button setSelected:NO];
        }
        [self addSubview:button];
        [self.buttons addObject:button];
    }
    
}
-(void)setCurrentPageAtIndex:(NSInteger)index{
    
    self.currentIndex=index;
    for (UIButton *btn in self.buttons) {
        if (btn.tag==index) {
            [btn setSelected:YES];
            [UIView animateWithDuration:0.35f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^
             {
                 CGPoint point=self.lineView.center;
                 point.x=btn.center.x;
                 [self.lineView setCenter:point];
             }  completion:nil];
        }
        else{
            [btn setSelected:NO];
        }
    }
}
-(void)buttonClick:(id)sender{
    UIButton *button=(UIButton *)sender;
    
    if (button.tag==self.currentIndex) {
        
    }
    else {
        for (UIButton *btn in self.buttons) {
            if ([btn isEqual:button]) {
                [btn setSelected:YES];
            }
            else{
                [btn setSelected:NO];
            }
        }
        self.currentIndex=button.tag;
        if (self.clickBlock) {
            self.clickBlock(self.currentIndex);
        }
        //移动箭头
        //动画过度
        
        [UIView animateWithDuration:0.35f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             CGPoint point=self.lineView.center;
             point.x=button.center.x;
             [self.lineView setCenter:point];
         }  completion:nil];
        
        
    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}




@end

@implementation SwitchLineView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    [self setClipsToBounds:YES];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.2);//线条颜色
    CGContextMoveToPoint(context,0-arrow_h/2, line_h);
    CGContextAddLineToPoint(context, rect.size.width/2-arrow_h/2,line_h);
    CGContextAddLineToPoint(context, rect.size.width/2-arrow_h/2+arrow_h/2,line_h-arrow_h/2);
    CGContextAddLineToPoint(context, rect.size.width/2-arrow_h/2+arrow_h,line_h);
    CGContextAddLineToPoint(context, rect.size.width*2-arrow_h/2,line_h);
    CGContextStrokePath(context);
}
@end
