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


/**
 * Full superview-based activity status view, occur full superview's frame.
 */
@interface SIStatusView : UIView

@property (nonatomic, readwrite, retain) UIView* titleView;
@property (nonatomic, readwrite, copy) NSString* subtitle;
@property (nonatomic, readonly, getter=isShowing) BOOL showing;

- (void)showLoading:(BOOL)show;
- (void)showEmpty:(BOOL)show;
- (void)showError:(BOOL)show;

@end
