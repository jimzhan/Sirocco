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


#import "SIAppDelegate.h"
#import "SIStyle.h"
#import "SiroccoMedia.h"


NSString * kChameleonObserverHost = @"http://localhost:9394";

static NSString* const kSIStyleSheetPath = @"Sirocco.bundle/stylesheets";
NSString* const kSIStyleSheet = @"sirocco.css";



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIAppDelegate

@synthesize window  = _window;
@synthesize style   = _style;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIWindow *) window {
    if (! _window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque]; 
    }
    return _window;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NIStylesheetCache *)style {
    return SIStylesheetCache();
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIApplicationDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    SIAudioEffectsPreload();
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
//    SIAudioEffectsUnload();
}


@end
