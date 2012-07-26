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

#import "UIViewController+SIRevealable.h"

#import "SiroccoCore.h"
#import "UIImage+SiroccoUI.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(UIViewController_SIRevealable)


@implementation UIViewController (SIRevealable)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setupForReveal {
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)]
        && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)]) {
        
        UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] 
                                                        initWithTarget:self.navigationController.parentViewController 
                                                        action:@selector(revealGesture:)];
        
        [self.navigationController.navigationBar addGestureRecognizer:panGestureRecognizer];
        [self.navigationController.view addGestureRecognizer:panGestureRecognizer];
        
        UIImage* menu = [UIImage imageWithPath:
                         NIPathForBundleResource(nil, @"SiroccoUI.bundle/menu.png")];
        
        UIBarButtonItem* list = [[UIBarButtonItem alloc] initWithImage:menu 
                                                                 style:UIBarButtonItemStylePlain 
                                                                target:self.navigationController.parentViewController 
                                                                action:@selector(revealToggle:)];
        self.navigationItem.leftBarButtonItem = list;
    }
}

@end
