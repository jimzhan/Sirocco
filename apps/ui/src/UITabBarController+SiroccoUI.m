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

#import "UITabBarController+SiroccoUI.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(UITabBarController_SiroccoUI)


@implementation UITabBarController (SiroccoUI)


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Native viewControllers property setter addon, inject the regular UIViewController into 
 * UINavigationController before adding it into UITabBar.
 */
- (void) setViewControllers:(NSArray *)viewControllers {
    NSMutableArray * views = [NSMutableArray arrayWithCapacity:viewControllers.count];
    for (int index; index < viewControllers.count; ++index) {
        id controller = [viewControllers objectAtIndex:index];
        if (! [controller isKindOfClass:[UINavigationController class]]) {
            controller = [[UINavigationController alloc] initWithRootViewController:controller];
        }
        [views addObject:controller];
    }
    [self setViewControllers:views animated:NO];
}

@end
