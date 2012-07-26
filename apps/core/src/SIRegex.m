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


#import "SIRegex.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
NSRegularExpression* SIRegex(NSString* pattern, NSRegularExpressionOptions options) {
    static NSMutableDictionary* RegexCache = nil;
    
    if (nil == RegexCache) {
        RegexCache = [NSMutableDictionary dictionary];        
    }
    
    NSRegularExpression* regex = [RegexCache valueForKey:pattern];
    if (nil == regex) {
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:NULL];
        [RegexCache setObject:regex forKey:pattern];
    }

    return regex;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL SIIsHexColor(NSString* string) {
    NSRegularExpression* regex = SIRegex(@"#(\\w{3}|\\w{6})", NSRegularExpressionCaseInsensitive);
    NSUInteger matches = [regex numberOfMatchesInString: string 
                                                options: 0 
                                                  range: NSMakeRange(0, [string length])];
    return matches == 1;
}