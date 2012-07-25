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


#import "UITableView+SiroccoUI.h"
#import "UIView+SiroccoUI.h"


NSString* const kSIReusableCellId = @"UITableViewCell";
NSString* const kSIReusableSectionId = @"UITableViewSection";


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NITableViewModel (SiroccoUI)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithListArray:(NSArray *)array {
    return [self initWithListArray:array delegate:(id)[NICellFactory class]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSectionedArray:(NSArray *)array {
    return [self initWithSectionedArray:array delegate:(id)[NICellFactory class]];
}
@end



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(UITableView_SiroccoUI)

static char const kPageIndexKey;
static char const kReuseIdentifierKey;
static char const kReloadedKey;
static char const kModelKey;
static char const kRefreshViewKey;


@implementation UITableView (SiroccoUI)


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties (NIPagingScrollingViewPage)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)pageIndex {
    return [[self getAssociatedObjectForKey:&kPageIndexKey] intValue];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setPageIndex:(NSInteger)pageIndex {
    [self setAssociatedObject:[NSNumber numberWithInt:pageIndex] forKey:&kPageIndexKey];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)reuseIdentifier {
    return [self getAssociatedObjectForKey:&kReuseIdentifierKey];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setReuseIdentifier:(NSString *)reuseIdentifier {
    [self setAssociatedObject:reuseIdentifier forKey:&kReuseIdentifierKey];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties (UIPagingScrollViewPage)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)reloaded {
    return [[self getAssociatedObjectForKey:&kReloadedKey] boolValue];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setReloaded:(BOOL)reloaded {
    [self setAssociatedObject:[NSNumber numberWithBool:reloaded] forKey:&kReloadedKey];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NITableViewModel *)model {
    return [self getAssociatedObjectForKey:&kModelKey];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setModel:(NITableViewModel *)model {
    [self setAssociatedObject:model forKey:&kModelKey];
    [self setReloaded:NO];
    if (self.dataSource != model) {
        [self setDataSource:model];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (EGORefreshTableHeaderView *)refreshView {
    EGORefreshTableHeaderView* view = [self getAssociatedObjectForKey:&kRefreshViewKey];
    if (! view) {
        CGRect frame = CGRectMake(self.top, -self.height, self.width, self.height);
        view = [[EGORefreshTableHeaderView alloc] initWithFrame:frame];
        view.backgroundColor = [UIColor clearColor];
        [self setAssociatedObject:view forKey:&kRefreshViewKey];
        [self addSubview:view];
    }
    return view;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)flush {
    if (self.dataSource && ! self.reloaded) {
        [self reloadData];
        [self setReloaded:YES];
    }
}

@end
