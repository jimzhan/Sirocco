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


/**
 * Helper class for accessing bundle & document resources.
 */
@interface SIPath : NSObject

/**
 * Sirocco bundle, singleton.
 */
+ (NSBundle *)bundle;


/**
 * Check if the given path is a valid system file.
 */
+ (BOOL)fileExists:(NSString *)path;


/**
 * Create a system path with the given va_list based components.
 */
+ (NSString *)pathWithComponents:(NSString *)component, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Create a absolute path for Sirocco's bundle resource.
 */
+ (NSString *)pathForBundle:(NSString *)path, ... NS_REQUIRES_NIL_TERMINATION;


/**
 * Create a absolute path to Document resource.
 */
+ (NSString *)pathForDocument:(NSString *)path, ... NS_REQUIRES_NIL_TERMINATION;

@end
