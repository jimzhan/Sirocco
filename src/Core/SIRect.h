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


#import "SICore.h"


#pragma mark - CGRect Methods

/**
 * Main screen bounds with device's orientation factored in.
 */
CGRect SIScreenBounds(void);


/**
 * Application frame with device's orientation factored in.
 */

CGRect SIAppFrame(void);


/**
 * Shortcut to make rect by using CGPoint & CGSize.
 */
CGRect SIRectMake(CGPoint point, CGSize size);


CGFloat SIHeightOfTableViewCell(void);


/**
 * Summerize all height of the visible subviews of the given view.
 */
CGFloat SIHeightOfSubviews(UIView* view);


/**
 * Create a size with device's resolution factored in.
 */
CGSize SISizeMake(CGFloat width, CGFloat height);


/**
 * Simply call sizeToFit for subviews of the given view.
 */
void SISubviewsToFit(UIView* view);


/**
 * Get the horizontally centered origin.x for the given view.
 *  NOTE If its superview is not found, the main screen will be used.
 *
 *  Args:
 *      * (UIView *)view: view that needs to be horizontally centered under its superview.
 *      * (UIEdgeInsets)insets: top/left/bottom/right padding for the superview.
 */
CGFloat SIRectGetMidXForView(UIView* view, UIEdgeInsets insets);



/**
 * Make all subviews of the given view horizontally & vertically center.
 *
 *  Args:
 *      * (UIView *) view: parent view which contains all the subviews needed to be centered.
 *      * (UIEdgeInsets) paddings: inner padding of the parent view.
 *      * (UIEdgeInsets) margins:  outter margins of subviews.
 */
void SICenterSubviews(UIView* view, UIEdgeInsets paddings, UIEdgeInsets margins);
