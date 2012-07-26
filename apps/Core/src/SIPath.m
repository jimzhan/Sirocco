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


#import "SIPath.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIPath


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSBundle *)bundle {
    static NSBundle* pkBundle = nil;
    if (nil == pkBundle) {
        NSString* path = [[[NSBundle mainBundle] resourcePath] 
                          stringByAppendingPathComponent:@"Sirocco.bundle"];
        pkBundle = [NSBundle bundleWithPath:path];
    }
    return pkBundle;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)pathWithComponents:(NSString *)component, ... {
    NIDASSERT(component);
    
    id segment = nil;
    
    va_list vargs;
    va_start(vargs, component);
    while ( (segment = (__bridge NSString *)va_arg(vargs, void *)) ) {
        component = [component stringByAppendingPathComponent:segment];
    }
    va_end(vargs);

    return component;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)fileExists:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)pathForBundle:(NSString *)path, ... {
    static NSString* pkResource = nil;
    if (nil == pkResource) {
        pkResource = [[self bundle] resourcePath];
    }
    
    NSString* abspath = pkResource;    
    
    if (path) {
        va_list vargs;
        va_start(vargs, path);
        for (NSString* segment = path; nil != segment; segment = va_arg(vargs, NSString*)) {
            if (! [segment hasPrefix:pkResource]) {
                abspath = [abspath stringByAppendingPathComponent:segment];
            }
        }
        va_end(vargs);
    }
    return abspath;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)pathForDocument:(NSString *)path, ... {
    static NSString* pkDocs = nil;
    if (nil == pkDocs) {
        pkDocs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                      NSUserDomainMask, 
                                                      YES) objectAtIndex:0];
    }

    NSString* abspath = pkDocs;
    
    if (path) {
        va_list vargs;
        va_start(vargs, path);
        for (NSString* segment = path; nil != segment; segment = va_arg(vargs, NSString*)) {
            if (! [segment hasPrefix:pkDocs]) {
                abspath = [abspath stringByAppendingPathComponent:segment];
            }
        }
        va_end(vargs);
    }
    return abspath;
}

@end
