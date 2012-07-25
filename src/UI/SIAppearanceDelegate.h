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

//  # /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.0.sdk/System/Library/Frameworks/UIKit.framework/Headers
//  $ grep -H UI_APPEARANCE_SELECTOR ./* | sed 's/ __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) UI_APPEARANCE_SELECTOR;//'

// # Supported Controls/Views (with implementions by conforming <UIAppearance>)
/*
* UIActivityIndicatorView
* UIBarButtonItem
* UIBarItem
* UINavigationBar
* UIProgressView
* UISearchBar
* UISegmentedControl
* UISlider
* UITabBar
* UITabBarItem
* UIToolbar
*/

#import <Foundation/Foundation.h>


// Class level image resource for global skining by using UIAppearance on iOS5.
@protocol SIAppearanceDelegate <NSObject>

@required
+ (void)customizeAppearance;

@optional
+ (void)customizeAppearanceWhenContainedIn:(Class <UIAppearanceContainer>)cls, ... NS_REQUIRES_NIL_TERMINATION;

@end
