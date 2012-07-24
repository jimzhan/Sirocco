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


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "NimbusCSS.h"
#import "NimbusCore+Additions.h"
#import "NimbusAttributedLabel.h"
#import "NimbusInterapp.h"
#import "NimbusLauncher.h"
#import "NimbusModels.h"
#import "NimbusNetworkControllers.h"
#import "NimbusOperations.h"
#import "NimbusOverview.h"
#import "NimbusPagingScrollView.h"
#import "NimbusPhotos.h"
#import "NimbusWebController.h"


#define WeakRef     __unsafe_unretained
#define iOSVersion  __IPHONE_OS_VERSION_MAX_ALLOWED


/**
 * Get the NIInMemoryCache singleton instance.
 */
NIMemoryCache* SICache(void);


/**
 * Create a unique cache key using the given seed.
 */
NSString* SICacheKey(NSString* seed);



/**
 * Create a standard URL string with scheme prepended (if not given).
 *
 *  Args:
 *      * (NSString *)URLString: plain string URL string.
 *
 *  Returns:
 *      Standard URL value, if not scheme is given, "http://" will be prepended.
 */
NSString* SIURLString(NSString* string);



/**
 * Fetch SDK verion info. by returning the major & minor verion numbers in float.
 *  i.e. 5.1, 4.2, 3.0
 */
CGFloat SISystemVersion(void);


/**
 * Check if current system support retina display.
 */
BOOL SIIsRetina(void);
