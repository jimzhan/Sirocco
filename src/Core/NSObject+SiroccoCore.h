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

#import <objc/message.h>
#import <objc/runtime.h>


@interface NSObject (SiroccoCore)


/**
 * Get the class name on instance level. (className property is only available on MacOS)
 */
- (NSString *)className;


/**
 * Perform the given selector with various length arguments.
 * NOTE that the given argument will NOT be retained.
 *
 *  Args:
 *      * (SEL) selector: selector on current NSObject. 
 */
- (id)execute:(SEL)selector, ...;


/**
 * Perform the given selector with various length arguments 
 * and boolean flag to indicate whether to retain the arguments.
 *
 *  Args:
 *      * (SEL) selector: selector on current NSObject. 
 *      * (BOOL) retainArguments: whether to retain these various length arguments.
 *
 *  Returns:
 *      NSObject or nil.
 */
- (id)execute:(SEL)selector retainArguments:(BOOL)retainArguments, ...;


/**
 * Perform the given selector with various list arguments
 * and boolean flag to indicate whether to retain the arguments.
 *
 *  Args:
 *      * (SEL) selector: selector on current NSObject.
 *      * (BOOL) retainArguments: whether to retain the arguments.
 *      * (va_list) arguments list: various arguments list.
 *
 *  Returns:
 *      NSObject or nil.
 */
- (id)execute:(SEL)selector retainArguments:(BOOL)retainArguments vargs:(va_list)vargs;


/**
 * Shortcut for getting associated object from the object itself by using a unique key.
 *
 *  Example:
 *      static const kUniqueExampleKey;
 *      [self getAssociatedObject:&kUniqueExampleKey];
 */
- (id)getAssociatedObjectForKey:(const void *)key;


/**
 * Shortcut for :func:`setAssociatedObject:forKey:withPolicy` by auto-checking
 * value's type to decide which policy we should be using.
 *
 *  Checking Rules:
 *      OBJC_ASSOCIATION_ASSIGN =>  Simple types without pointers.
 *      OBJC_ASSOCIATION_COPY   =>  Object conform NSCopying Protocol.
 *      OBJC_ASSOCIATION_RETAIN =>  Regular NSObject.
 *
 *  Details: <https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocProperties.html#//apple_ref/doc/uid/TP30001163-CH17-SW13>
 */
- (void)setAssociatedObject:(id)value forKey:(const void *)key;


@end
