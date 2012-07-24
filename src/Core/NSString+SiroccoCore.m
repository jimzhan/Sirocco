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


#import "NSString+SiroccoCore.h"

#import "SIRegex.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(NSString_SiroccoCore)


@implementation NSString (SiroccoCore)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray *)stringsBySplittingWithSeparator:(NSString *)separator {
    NSMutableArray * strings;
    if (separator) {
        strings = (NSMutableArray *) [self componentsSeparatedByString:separator];
    } else {
        strings = (NSMutableArray *) [self componentsSeparatedByString:@" "];
    }
    
    for (int index = 0; index < strings.count; ++index) {
        [strings replaceObjectAtIndex:index withObject:[[strings objectAtIndex:index] stringByTrimmingSpaces]];
    }
    return strings;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringByTrimmingSpaces {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)stringWithData:(NSData *)data {
    return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringByAppendingPathComponents:(NSString *)component, ... {
    if (component) {
        NSString* path = component;
        NSString* segment = nil;
        va_list vargs;
        va_start(vargs, component);
        while ( (segment = va_arg(vargs, NSString*)) ) {
            path = [path stringByAppendingPathComponent:segment];
        }
        va_end(vargs);
        return path;
    }
    return self;
}

@end
