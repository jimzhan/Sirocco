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


/**
 * Create a regular expression with string pattern & relative options.
 *
 *  Args:
 *      * (NSString *)pattern: string based regular expression pattern.
 *      * (NSRegularExpressionOptions)options: options for matching regular expression pattern.
 *
 *  Returns:
 *      Compiled reguar expression with global cache support, meaning that same regex
 *      will be compiled only once.
 */
NSRegularExpression* SIRegex(NSString* pattern, NSRegularExpressionOptions options);


/**
 * Check if the given string value is matched with hex color value like "#abc" or "#abc123".
 *
 *  Args:
 *      * (NSString*) string: string value for check.
 *
 *  Returns:
 *      boolean value to indicate whether the given value is valid hex color value.
 */
BOOL SIIsHexColor(NSString* string);
