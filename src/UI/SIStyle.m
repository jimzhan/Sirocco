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


#import "SIStyle.h"


NSString* const kSIStylesheet = @"sirocco-default.css";


///////////////////////////////////////////////////////////////////////////////////////////////////
static NSString* const kStylesheetsPath = @"Sirocco.bundle/stylesheets";




///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
NIStylesheetCache* SIStylesheetCache(void) {
    static NIStylesheetCache* kStylesheetCache = nil;
    if (nil == kStylesheetCache) {
        NSString* path = SIPathForResource(kStylesheetsPath);
        kStylesheetCache = [[NIStylesheetCache alloc] initWithPathPrefix:path];
    }
    return kStylesheetCache;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NIStylesheet* SIStylesheet(NSString* filename) {
    NIStylesheetCache* cache = SIStylesheetCache();
    return [cache stylesheetWithPath:filename ? filename : kSIStylesheet];
}

