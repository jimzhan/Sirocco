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


/**
 * Create a path with the Sirocco bundle and the relative path appended.
 *
 *      @param path  The relative path to append to the bundle's path.
 *
 *      @returns The bundle path concatenated with the given relative path.
 */
NSString* SIPathForResource(NSString* path);
NSString* SIPathForBundleResource(NSString* path, ...);

/**                                                     
 * Create a path with the documents directory and the relative path appended.
 *
 *      @param path  The relative path to append to the Document Directory's path. 
 *  
 *      @returns The documents path concatenated with the given relative path.
 */
NSString* SIPathForDocument(NSString* path);



/**
 * Create a UIImage with the path from default bundle.
 *
 *  TODO: Landscape & device supports.
 *
 *  @param filename The relative image path to append to the bundle's path.
 *  @returns The UIImage from the bundle path concatenated with the given relative path.
 */
//UIImage* SIImage(NSString* path);
//UIImage* SIImageWithOrientation(NSString* path, UIDeviceOrientation orientation);



/**
 * Shortcut to check if the resource is exists.
 */
BOOL SIFileExistsAtPath(NSString* path);
