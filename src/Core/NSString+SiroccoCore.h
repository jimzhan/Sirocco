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
#import <NimbusCore.h>


@interface NSString (SiroccoCore)

- (NSArray *)stringsBySplittingWithSeparator:(NSString *)separator;

- (NSString *)stringByTrimmingSpaces;

/**
 * Convert NSData instance to NSString using UTF-8 encoding.
 */
+ (NSString *)stringWithData:(NSData *)data;

- (NSString *)stringByAppendingPathComponents:(NSString *)component, ... NS_REQUIRES_NIL_TERMINATION;

@end
