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


#import "SiroccoCore.h"
#import "EGORefreshTableHeaderView.h"


extern NSString* const kSIReusableCellId;
extern NSString* const kSIReusableSectionId;


/**
 * NITableView addons with default delegate (NICellFactory) supports.
 */
@interface NITableViewModel (SiroccoUI)
- (id)initWithListArray:(NSArray *)array;
- (id)initWithSectionedArray:(NSArray *)array;
@end


/**
 * TableView addons with model-based refresh header & pagination support.
 */
@interface UITableView (SiroccoUI) <NIPagingScrollViewPage>

@property (nonatomic, readwrite, assign) NSInteger pageIndex;
@property (nonatomic, readwrite, copy) NSString* reuseIdentifier;

@property (nonatomic, readonly,  assign) BOOL reloaded;
@property (nonatomic, readwrite, retain) NITableViewModel* model;
@property (nonatomic, readonly,  retain) EGORefreshTableHeaderView* refreshView;

// Update dataSource with model (if existing) & reload table data.
- (void)flush;

@end
