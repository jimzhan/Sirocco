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


///////////////////////////////////////////////////////////////////////////////////////////////////
NIMemoryCache* SICache(void) {
    static NIMemoryCache* Cache = nil;
    if (nil == Cache) {
        Cache = [[NIMemoryCache alloc] init];
    }
    return Cache;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* SICacheKey(NSString* seed) {
    NIDASSERT(nil != seed);
    return [seed md5Hash];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* SIURLString(NSString* string) {
    BOOL hasScheme = [string hasPrefix:@"http://"] 
                    || [string hasPrefix:@"https://"] 
                    || [string hasPrefix:@"ftp://"];
    return hasScheme ? string : [NSString stringWithFormat:@"http://%@", string];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat SISystemVersion(void) {
    CGFloat version = 0.0f;

    switch (__IPHONE_OS_VERSION_MAX_ALLOWED) {
        case NIIOS_2_0:
            version = 2.0f;
            break;
        case NIIOS_2_1:
            version = 2.1f;
            break;            
        case NIIOS_2_2:
            version = 2.2f;
            break;            
        case NIIOS_3_0:
            version = 3.0f;
            break;
        case NIIOS_3_1:
            version = 3.1f;
            break;
        case NIIOS_3_2:
            version = 3.2f;
            break;
        case NIIOS_4_0:
            version = 4.0f;
            break;
        case NIIOS_4_1:
            version = 4.1f;
            break;
        case NIIOS_4_2:
            version = 4.2f;
            break;
        case NIIOS_4_3:
            version = 4.3f;
            break;
        case NIIOS_5_0:
            version = 5.0f;
            break;
        default:
            break;
    }
    return version;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL SIIsRetina(void) {
    UIScreen* screen = [UIScreen mainScreen];
    return [screen respondsToSelector:@selector(scale)] && [screen scale] >= 2.0f;
}