//
// Copyright 2012 Jim Zhan
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//


#import "SIStatusView.h"

#import "UIView+SiroccoUI.h"


static CGFloat const kContentHeight     = 44.0f;
static NSInteger const kLoadingDuration = 3;


///////////////////////////////////////////////////////////////////////////////////////////////////
// Private
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface SIStatusView ()
@property (nonatomic, readwrite, retain) UIView* parent;
@property (nonatomic, readwrite, retain) UILabel* subtitleView;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIStatusView

@synthesize parent;
@synthesize subtitleView= _subtitleView;
@dynamic loading;

@synthesize titleView   = _titleView;
@synthesize subtitle    = _subtitle;
@dynamic showing;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleDimensions;
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel *)subtitleView {
    if (! _subtitleView) {
        _subtitleView = [[NIAttributedLabel alloc] init];
        _subtitleView.size = CGSizeMake(self.width, kContentHeight);     
        _subtitleView.contentMode = UIViewContentModeCenter;
        _subtitleView.autoresizingMask = UIViewAutoresizingFlexibleMargins;
        _subtitleView.backgroundColor = [UIColor clearColor];
        [self addSubview:_subtitleView];  
    }
    return _subtitleView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading {
    return self.showing && [self.titleView isKindOfClass:[UIActivityIndicatorView class]];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)show:(BOOL)show {
    if (! self.parent) return;
    
    for (UIView* subview in self.parent.subviews) {
        if (subview != self) [subview setHidden:show];
    }
    
    if (show) {
        [self setFrame:self.parent.bounds];
        [self.parent addSubviewIfNeeded:self];
        [self.parent bringSubviewToFront:self];
    } else {
        [self.parent sendSubviewToBack:self];
        [self removeFromSuperview];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    SICenterSubviews(self, UIEdgeInsetsZero, UIEdgeInsetsZero);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// memorize its superview when first added.
- (void)didMoveToSuperview {
    if (self.parent != self.superview) {
        self.parent = self.superview;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isShowing {
    return (nil != self.superview);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTitleView:(UIView *)view {
    if (_titleView != view) {
        [_titleView removeFromSuperview];
        _titleView = view;
        
        if (_titleView) {
            _titleView.size = CGSizeMake(self.width, kContentHeight);
            _titleView.contentMode = UIViewContentModeCenter;
            _titleView.autoresizingMask = UIViewAutoresizingFlexibleMargins;
            _titleView.backgroundColor = [UIColor clearColor];
            [self addSubview:_titleView];            
            
            if ([_titleView isKindOfClass:[UIActivityIndicatorView class]]) {
                [_titleView execute:@selector(startAnimating)];
            }
        }
    } 
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSubtitle:(NSString *)subtitle {
    if (_subtitle != subtitle) {
        _subtitle = subtitle;
        
        if (_subtitle) {
            self.subtitleView.text = _subtitle;
            self.subtitleView.size = [_subtitle sizeWithFont:self.subtitleView.font];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateLoading { if (self.loading) self.subtitle = SILocalizedString(@"Still Working..."); }
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showLoading:(BOOL)show {
    if (show) {
        self.titleView = [[UIActivityIndicatorView alloc] 
                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        self.subtitle = SILocalizedString(@"Loading...");
        [self performSelector:@selector(updateLoading) withObject:nil afterDelay:kLoadingDuration];
    }
    [self show:show];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showEmpty:(BOOL)show {

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showError:(BOOL)show {

}

@end
