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


#import "SIResource.h"
#import "SIRegex.h"



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods

///////////////////////////////////////////////////////////////////////////////////////////////////
static NSBundle* SIBundle(void) {
    static NSBundle* pkBundle = nil;
    if (nil == pkBundle) {
        NSString* path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Sirocco.bundle"];
        pkBundle = [NSBundle bundleWithPath:path];
    }
    return pkBundle;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
static NSString* const pkRetinaSuffix = @"@2x";
///////////////////////////////////////////////////////////////////////////////////////////////////
static NSString* SIPathForRetina(NSString* path, UIDeviceOrientation orientation) {
    NSString* extension = path.pathExtension.length ? path.pathExtension : @"png";
    NSString* basename = [path stringByDeletingPathExtension];
    
    if (SIIsRetina() && ! [basename hasSuffix:pkRetinaSuffix]) {
        NSString* abs = [basename stringByAppendingFormat:@"%@.%@", pkRetinaSuffix, extension];
        if (SIFileExistsAtPath(abs)) {
            basename = [basename stringByAppendingString:pkRetinaSuffix];
        }
    }
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        basename = [basename stringByAppendingString:@"-Landscape"];
    }
    
    return [basename stringByAppendingPathExtension:extension];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Resources

///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* SIPathForResource(NSString* path) {
    static NSString* pkResourcePath = nil;
    if (nil == pkResourcePath) {
        pkResourcePath = [SIBundle() resourcePath];
    }
    
    return ([path hasPrefix:pkResourcePath]) ? path : [pkResourcePath stringByAppendingString:path];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* SIPathForBundleResource(NSString* path, ...) {
    NSMutableString* abspath = [NSMutableString string];
 /*   
    va_list args;
    va_start(args, path);
    for (NSString *arg = path; arg != nil; arg = va_arg(args, NSString*))
    {
        [abspath appendString:arg];
    }
    va_end(args);
   */ 
    if (! [abspath hasPrefix:[SIBundle() resourcePath]]) {
        abspath = (NSMutableString *)[[SIBundle() resourcePath] stringByAppendingPathComponent:abspath];
    }

    
    return abspath;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* SIPathForDocument(NSString* path) {
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                             NSUserDomainMask, 
                                                             YES) objectAtIndex:0];
    }
    return [documentsPath stringByAppendingPathComponent:path];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL SIFileExistsAtPath(NSString* path) {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
