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


#import "SIActivityLabel.h"

#import "UIView+SiroccoUI.h"


UIEdgeInsets kPaddings = (UIEdgeInsets){5, 5, 5, 5};


@interface SIActivityLabel ()

@property (nonatomic, readwrite, assign) UIActivityIndicatorViewStyle indicatorStyle;
@end;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIActivityLabel

@synthesize indicatorStyle;

@synthesize text = _text;
@synthesize label = _label;
@synthesize activityIndicator = _activityIndicator;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    return [self initWithFrame:CGRectZero style:UIActivityIndicatorViewStyleGray];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UIActivityIndicatorViewStyleGray];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UIActivityIndicatorViewStyle)style {
    return [self initWithFrame:CGRectZero style:style];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame style:(UIActivityIndicatorViewStyle)style {
    if (self = [super initWithFrame:frame]) {

        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        [_activityIndicator startAnimating];

        _label = [[NIAttributedLabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = SILocalizedString(@"Loading...");
        
        [self addSubview:_activityIndicator];
        [self addSubview:_label];

    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    // horizontal align for elements inline.
    
    CGSize indicatorSize = self.activityIndicator.size;    
    CGSize textSize = [self.label.text sizeWithFont:self.label.font];
    
    [self.activityIndicator sizeToFit];
    if (self.activityIndicator.isAnimating) {
        if (indicatorSize.height > textSize.height) {
            indicatorSize.height = textSize.height;
        }
    }

    // integral content size
    CGFloat width  = indicatorSize.width + textSize.width + (kPaddings.left + kPaddings.right) * 2;
    CGFloat height = (textSize.height > indicatorSize.height ? textSize.height : indicatorSize.height) 
                    + kPaddings.top + kPaddings.bottom;
    
    CGFloat X = floorf((self.width - width) / 2);
    CGFloat Y = floorf((self.height - height) / 2);
    
    self.activityIndicator.frame = SIRectMake(CGPointMake(X, Y), indicatorSize);
    
    X = self.activityIndicator.right + kPaddings.right + kPaddings.left;
    self.label.frame = SIRectMake(CGPointMake(X, Y), textSize);

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.activityIndicator stopAnimating];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setText:(NSString *)text {
    if (self.label.text != text) {
        self.label.text = text;
        [self setNeedsLayout];
    }
}


@end
