//
//  NCMenuView.m
//  NCMenuViewDemo
//
//  Created by li naicai on 15/8/26.
//  Copyright (c) 2015年 li naicai. All rights reserved.
//

#import "NCMenuView.h"
#define line_h 40
#define arrow_h 12
#define DEFAULT_COLOR         [UIColor colorWithRed:244/255.0 green:54/255.0 blue:64/255.0 alpha:1.0]
#define DEFAULT_COLOR_1       [self colorWithHexString:@"00ccff"]
@implementation NCMenuView
- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)title Complete:(ClickBlock)complete ShowLineView:(BOOL)showLineView LineStyle:(lineStyle)style{
    self.style=style;
    return [self initWithFrame:frame Titles:title Complete:complete ShowLineView:showLineView];

}
- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)title Complete:(ClickBlock)complete ShowLineView:(BOOL)showLineView{
    self = [super initWithFrame:frame];
    if (self) {
        self.clickBlock=[complete copy];
        self.titles=[title copy];
        self.currentIndex=0;
        self.showLineView=showLineView;
        [self setBackgroundColor:[UIColor clearColor]];
        [self initControl];
        [self setClipsToBounds:NO];

    }
    return self;
}
- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)title Complete:(ClickBlock)complete
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clickBlock=[complete copy];
        self.titles=[title copy];
        self.currentIndex=0;
        self.showLineView=YES;
        [self setBackgroundColor:[UIColor clearColor]];
        [self initControl];
        [self setClipsToBounds:NO];
    }
    return self;
}
-(void)initControl{



    self.buttons=[NSMutableArray array];
    for (id title in self.titles) {
        NSInteger i=[self.titles indexOfObject:title];
        NSInteger with=self.bounds.size.width/self.titles.count;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:DEFAULT_COLOR forState:UIControlStateHighlighted];
        [button setTitleColor:DEFAULT_COLOR forState:UIControlStateSelected];
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
    CGRect rect=self.bounds;
    rect.size.width*=self.titles.count;
    switch (self.style) {
        case default_arrow:
        {
            self.lineView=[[ArrowView alloc]initWithFrame:rect];
            [self.lineView setBackgroundColor:[UIColor clearColor]];
            [self.lineView setHidden:!self.showLineView];
            [self addSubview:self.lineView];
        }
            break;
        case default_line:
        {
            NSString *str= [self.titles firstObject];
            UIButton *button=[self.buttons firstObject];
            CGFloat w=15;
            self.lineView=[[LineView alloc]initWithFrame:CGRectMake(button.center.x-w*str.length/2, 35,w*str.length, 3)];
            [self.lineView setBackgroundColor:DEFAULT_COLOR];
            [self.lineView setHidden:!self.showLineView];
            [self addSubview:self.lineView];
        }
            break;
            
        default:
            break;
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

- (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



@end

@implementation ArrowView
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
    
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.2);//线条颜色
    CGContextMoveToPoint(context,0-arrow_h/2, line_h);
    CGContextAddLineToPoint(context, rect.size.width/2-arrow_h/2,line_h);
    CGContextAddLineToPoint(context, rect.size.width/2-arrow_h/2+arrow_h/2,line_h-arrow_h/2);
    CGContextAddLineToPoint(context, rect.size.width/2-arrow_h/2+arrow_h,line_h);
    CGContextAddLineToPoint(context, rect.size.width*2-arrow_h/2,line_h);
    CGContextStrokePath(context);
}
@end
@implementation LineView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
@end
