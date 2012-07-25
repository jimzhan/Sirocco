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


#import "UITableViewCell+SiroccoUI.h"

#import "UIView+SiroccoUI.h"



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(UITableViewCell_SiroccoUI)


@implementation UITableViewCell (SiroccoUI)

static char const kDetailViewKey;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)detailView {
    return [self getAssociatedObjectForKey:&kDetailViewKey];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDetailView:(UIView *)detailView {
    [self setAssociatedObject:detailView forKey:&kDetailViewKey];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isExpanded {
    UIView* view = [self detailView];
    return view && view.superview;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isExpandable {
    return (nil != self.detailView);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)expand:(BOOL)flag {
    if (! self.expandable) return;
    UIImage* accessory = [UIImage imageNamed:flag ? kSIOpenAccessory : kSICloseAccessory];    
    self.accessoryView = [[UIImageView alloc] initWithImage:accessory];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)toggleExpansion {
    if (! self.expandable) return;

    if (self.expanded) {
        [self.detailView removeFromSuperview];
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kSICloseAccessory]];
    } else {
        CGFloat bottom = 0.0f;
        for (UIView* subview in self.contentView.subviews) {
            bottom += subview.height;
        }
        self.detailView.top = bottom - self.detailView.height;
        [self.contentView addSubview:self.detailView];
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kSIOpenAccessory]];
    }
}

@end
