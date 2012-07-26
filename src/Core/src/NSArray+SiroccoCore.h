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

#import <NimbusCore.h>
#import "SIBlock.h"


@interface NSArray (SiroccoCore)

/**
 * Check if there's any True (or not nil if block is not given) item in the array.
 * Behave exactly like any() in Python.
 *
 *  Args:
 *      (SIArrayFilterBlock)block: py-lambda like filter to check individual array item.
 *
 *  Returns:
 *      YES if any item fulfill the critieria defined in the block.
 */
- (BOOL)any:(SIBlock)block;


/**
 * Check if all array items are True (or not nil if block is not given) item in the array.
 * Behave exactly like all() in Python.
 *
 *  Args:
 *      (SIArrayFilterBlock)block: py-lambda like filter to check individual array item.
 *
 *  Returns:
 *      YES if all items fulfill the critieria defined in the block.
 */
- (BOOL)all:(SIBlock)block;


@end
