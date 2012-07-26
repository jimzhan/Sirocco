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


extern NSString* kSIAppearance;



@interface SIAppearance : NSObject

+ (BOOL)appearanceAvailable;

+ (void)customizeAppearances;

+ (NSString *)pathForContainer:(Class)cls;

+ (NSString *)pathForContainer:(Class)cls control:(NSString *)control;

@end


 
 /**
 * Check if the runtime support UIAppearance delegate for styling.
 */
//BOOL SIAppearanceAvailable(void);


/**
 * Setup the appearance images by using defined kSiroccoStyle marco
 * default value is "Default", means that images will be gettings under
 * directory: "Sirocco.bundle/images/Default".
 */
//void SISetupAppearances(void);



/**
 * Customize native appearances of native controls.
 *
 * Prior to iOS 5, this just simply send the notification
 * out for all registered views and let them do their own 
 * customization. While on iOS 5 & after, use UIAppearance
 * directly.
 */
//void SICustomizeAppearance(void);
