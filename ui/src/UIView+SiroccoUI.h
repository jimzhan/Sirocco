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

#import "SiroccoCore.h"


@interface UIView (SiroccoUI)


#pragma mark - Positions & Sizes of frame
// Followings are the simple shortcuts to frame's properties,
// except that, these setters will also reassign the frame with
// new values.
@property (nonatomic, readwrite) CGFloat left;
@property (nonatomic, readwrite) CGFloat top;
@property (nonatomic, readwrite) CGFloat right;
@property (nonatomic, readwrite) CGFloat bottom;

@property (nonatomic, readwrite) CGFloat width;
@property (nonatomic, readwrite) CGFloat height;

@property (nonatomic, readwrite) CGPoint origin;
@property (nonatomic, readwrite) CGSize  size;


/**
 * Opposite to removeFromSuperview, add this view to its superview (if exists).
 * NOTE this will NOT function if the view had not been added before.
 */
- (void)addToSuperview;


/**
 * In addition to the standard addSubview: selector,
 * this method will check if the subview is already in
 * its subviews before actually adding it.
 */
- (void)addSubviewIfNeeded:(UIView *)subview;


/**
 * Remove all subviews.
 */
- (void)removeAllSubviews;


/**
 * Shortcut helper to toggle visibility of  all subviews.
 */
- (void)showAllSubviews:(BOOL)show;


/**
 * Replace the existing subview with another view.
 *
 *  Args:
 *      (UIView *)subview: existing subview.
 *      (UIView *)view: existing subview's replacement.
 */
- (void)replaceSubview:(UIView *)subview with:(UIView *)view;


/**
 * Generate a sha1-based view tag for the given name
 * by placing current class name as its prefix.
 *
 *  Args:
 *      (NSString *)name: name to generate the view tag.
 */
- (NSInteger)tagForName:(NSString *)name;

@end
