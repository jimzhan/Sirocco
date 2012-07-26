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


#import "SIPageTableController.h"


CGFloat kSIPageControlHeight = 20.0f;


///////////////////////////////////////////////////////////////////////////////////////////////////
// Private properties
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface SIPageTableController ()
// For some reasons dequeue from NIPagingScrollView instance does not work,
// so we use dictionary as the tempoary solution here.
@property (nonatomic, readonly, retain) SIObject* views;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIPageTableController

@synthesize views  = _views;

@synthesize pageView    = _pageView;
@synthesize pageControl = _pageControl;
@synthesize numberOfPages = _numberOfPages;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        _views  = [[SIObject alloc] initWithID:@"%@::views",  self.className];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NIPagingScrollView *)pageView {
    if (! _pageView) {
        CGRect frame = NIRectContract(self.view.bounds, 0, kSIPageControlHeight);
        _pageView = [[NIPagingScrollView alloc] initWithFrame:frame];
        _pageView.delegate = self;
        _pageView.dataSource = self;
        _pageView.backgroundColor = self.view.backgroundColor;
        [_pageView reloadData];
    }
    return _pageView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIPageControl *)pageControl {
    if (! _pageControl) {
        CGRect frame = NIRectShift(self.view.bounds, 0, self.pageView.height);
        _pageControl = [[UIPageControl alloc] initWithFrame:frame];
        _pageControl.numberOfPages = self.numberOfPages;        
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleMargins;
        _pageControl.enabled = NO;
        _pageControl.hidesForSinglePage = NO;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];    
        _pageControl.defersCurrentPageDisplay = YES;        
    }
    return _pageControl;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle


///////////////////////////////////////////////////////////////////////////////////////////////////
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];

    [self.view addSubview:self.pageView];
    [self.view addSubview:self.pageControl];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NIPagingScrollViewDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfPagesInPagingScrollView:(NIPagingScrollView *)pagingScrollView {
    return self.numberOfPages;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// FIXME strange that dequeResuablePageWithIdentifier totally lost the previous page here.
- (UITableView<NIPagingScrollViewPage> *)pagingScrollView:(NIPagingScrollView *)pagingScrollView 
                                         pageViewForIndex:(NSInteger)pageIndex {

    NSString* key = [NSString stringWithFormat:@"view::%d", pageIndex];
    UITableView* tableView  = [self.views objectForKey:key];

    if (nil == tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        tableView.delegate = self;
        tableView.refreshView.delegate = self;
        [self.views setObject:tableView forKey:key];
    }

    // update the model data if there's any updated model.
    [tableView flush];

    return (UITableView<NIPagingScrollViewPage> *) tableView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NIPagingScrollViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)pagingScrollViewDidChangePages:(NIPagingScrollView *)pagingScrollView {
    self.pageControl.currentPage = pagingScrollView.centerPageIndex;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableView *)tableView {
    return [self tableViewForPage:self.pageView.centerPageIndex];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableView *)tableViewForPage:(NSInteger)page {
    return (UITableView *) [self pagingScrollView:self.pageView pageViewForIndex:page];
}

@end