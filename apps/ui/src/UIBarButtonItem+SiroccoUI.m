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

#import "UIBarButtonItem+SiroccoUI.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(UIBarButtonItem_SiroccoUI)


@implementation UIBarButtonItem (SiroccoUI)


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class public

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIBarButtonItem *)backButton {
    return [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil)
                                            style:UIBarButtonItemStylePlain 
                                           target:nil 
                                           action:nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIBarButtonItem *)fixedSpace {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
                                                         target:nil 
                                                         action:nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIBarButtonItem *)flexibleSpace {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                         target:nil 
                                                         action:nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setSize:image.size];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
