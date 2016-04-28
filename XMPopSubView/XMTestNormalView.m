//
//  XMTestNormalView.m
//  XMPopSubView
//
//  Created by will.xu on 16/4/27.
//

#import "XMTestNormalView.h"

@implementation XMTestNormalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.text = @"自定义视图哦";
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_label sizeToFit];
    _label.frame = self.bounds;
}

@end
