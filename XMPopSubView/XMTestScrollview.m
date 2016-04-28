//
//  XMTestScrollview.m
//  XMPopSubView
//
//  Created by will.xu on 16/4/28.
//

#import "XMTestScrollview.h"

@interface XMTestScrollview ()
{
    UIScrollView *_contentScrollView;
    UIImageView *_firstImageView;
    UIImageView *_secondImageView;
}


@end

@implementation XMTestScrollview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customedInitSubViews];
    }
    return self;
}


-(void)customedInitSubViews{
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = YES;
    [self addSubview:_contentScrollView];
    
    
    _firstImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _firstImageView.contentMode = UIViewContentModeScaleToFill;
    _firstImageView.image = [UIImage imageNamed:@"image_1.jpg"];
    
    _secondImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _secondImageView.contentMode = UIViewContentModeScaleToFill;
    _secondImageView.image = [UIImage imageNamed:@"image_2.jpg"];
    
    [_contentScrollView addSubview:_firstImageView];
    [_contentScrollView addSubview:_secondImageView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _contentScrollView.frame = self.bounds;
    _contentScrollView.contentSize = CGSizeMake(self.width*2, self.height);
    _firstImageView.frame = CGRectMake(0, 0, self.width, self.height);
    _secondImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
}

@end
