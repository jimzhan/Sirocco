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


#import "SIRect.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CGRect Methods

///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect SIRectMake(CGPoint point, CGSize size) {
    return CGRectMake(point.x, point.y, size.width, size.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect SIScreenBounds() {
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (UIInterfaceOrientationIsLandscape(NIInterfaceOrientation())) {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    return bounds;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect SIAppFrame() {
    // TODO nav/toolbar factored in.
    return [UIScreen mainScreen].applicationFrame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat SIHeightOfSubviews(UIView* view) {
    CGFloat height = 0.0f;
    for (UIView* subview in view.subviews) {
        if (subview.hidden) continue;
        height += CGRectGetHeight(subview.frame);
    }
    return height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGSize SISizeMake(CGFloat width, CGFloat height) {
    if (SIIsRetina()) {
        width   *= 2.0f;
        height  *= 2.0f;
    }
    return CGSizeMake(width, height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void SISubviewsToFit(UIView* view) {
    for (UIView* subview in view.subviews) {
        [subview sizeToFit];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat SIRectGetMidXForView(UIView* view, UIEdgeInsets insets) {
    // ensure we have the actual size of the view first.
    
    CGFloat width;
    if (view.superview) {
        width = CGRectGetWidth(view.superview.frame);
    } else {
        width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    }
    width -= insets.left + insets.right;

    return floor((width - CGRectGetWidth(view.frame)) / 2.0f);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void SICenterSubviews(UIView* view, UIEdgeInsets paddings, UIEdgeInsets margins) {
    // ensure all subviews has their actual sizes before re-positioning.
    SISubviewsToFit(view);

    // Superview's inner paddings
    CGFloat W   = CGRectGetWidth(view.frame) - paddings.left - paddings.right;
    CGFloat H   = CGRectGetHeight(view.frame) - paddings.top - paddings.bottom;
    CGFloat top = floorf((H - SIHeightOfSubviews(view)) / 2.0f);

    // Subviews's outter margins
    for (UIView* subview in view.subviews) {
        CGRect frame = subview.frame;
        CGFloat left = floorf((W - CGRectGetWidth(subview.frame) + margins.left + margins.right) / 2.0f);        
        frame.origin = CGPointMake(left, top + margins.top);
        subview.frame = frame;
        top += CGRectGetHeight(subview.frame) + margins.bottom;
    }
}
