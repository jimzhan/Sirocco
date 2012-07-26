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


#import "NSArray+SiroccoCore.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(NSArray_SiroccoCore)


@implementation NSArray (SiroccoCore)


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)any:(SIBlock)block {
    NSEnumerator* enumerator = [self objectEnumerator];
    id object;
    while (object = [enumerator nextObject]) {
        if (block && block(object)) {
            return YES;
        }
    }
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)all:(SIBlock)block {
    NSEnumerator* enumerator = [self objectEnumerator];
    id object;
    while (object = [enumerator nextObject]) {
        if (block && ! block(object)) {
            return NO;
        }
    }
    return YES;
}

@end
