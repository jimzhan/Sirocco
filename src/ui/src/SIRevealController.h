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

#import <UIKit/UIKit.h>
#import <ZUUIRevealController.h>


#ifndef SIROCCO_UI_REVEAL
    #define SIROCCO_UI_REVEAL @"SiroccoUI.bundle/reveal.png"
#endif



@interface SIRevealController : ZUUIRevealController <ZUUIRevealControllerDelegate>

@property (nonatomic, readwrite, retain) UIViewController* mainController;
@property (nonatomic, readwrite, retain) UIViewController* menuController;

/**
 * Create revealable view controller with main/front view & menu.
 *
 *      @param mainController: main view controller for regular interactions.
 *      @param menu: path to plist file which contains the detailed menu list,
 *                  NOTE: string => table section, dict => detailed menu item (id + name + enabled).
 *
 */
- (id)initWithMainController:(UIViewController *)mainController menu:(NSString *)menu;

@end
