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


#import "UIView+GradientLayer.h"
#import <QuartzCore/QuartzCore.h>



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(UIView_GradientLayer)


@implementation UIView (GradientLayer)


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class public UIView

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (Class)layerClass {
    return [CAGradientLayer class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods UIView (GradientLayer)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setGradientColors:(NSArray *)colors {
    NSInteger total = [colors count];
    CGFloat ratio = floorf(1.0f / total);
    NSMutableArray* gradients = [NSMutableArray arrayWithCapacity:total];
    NSMutableArray* locations = [NSMutableArray arrayWithCapacity:total];
    
    for (NSInteger index = 0; index < total; ++index) {
        [gradients addObject:(id)[[colors objectAtIndex:index] CGColor]];
        if (index == 0) {
            [locations addObject:[NSNumber numberWithFloat:0.0f]];
        } else if (index + 1 == total) {
            [locations addObject:[NSNumber numberWithFloat:1.0f]];
        } else {
            [locations addObject:[NSNumber numberWithFloat:index * ratio]];
        }
    }

    [(CAGradientLayer *)self.layer setColors:gradients];
    [(CAGradientLayer *)self.layer setLocations:locations];
}

@end
