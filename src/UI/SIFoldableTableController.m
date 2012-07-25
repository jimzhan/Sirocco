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


#import "SIFoldableTableController.h"
#import "SISection.h"


CGFloat kSITableViewSectionHeight = 40.0f;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIFoldableTableController

@synthesize openedSection;
@synthesize sections = _sections;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _sections = [NSMutableArray array];
        self.openedSection = NSNotFound;
    }
    return self;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = (id<UITableViewDataSource>) self;
    self.tableView.sectionHeaderHeight = kSITableViewSectionHeight;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)index {
    SISection* section = [self.sections objectAtIndex:index];
    return (section && section.opened) ? section.rows.count : 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - SISectionViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView sectionOpened:(NSInteger)index {
    SISection *section=[self.sections objectAtIndex:index];
    section.opened = YES;    
    
    NSMutableArray *inserts = [NSMutableArray array];
    for (NSInteger row = 0; row < section.rows.count; ++row) {
        [inserts addObject:[NSIndexPath indexPathForRow:row inSection:index]];
    }   
    
    NSMutableArray *deletes = [NSMutableArray array];
    if (NSNotFound != self.openedSection) {
        SISection *previous = [self.sections objectAtIndex:self.openedSection];
        previous.opened = NO;
        [previous toggleOpenWithUserAction:NO];
        for (NSInteger row = 0; row < previous.rows.count; ++row) {
            [deletes addObject:[NSIndexPath indexPathForRow:row inSection:self.openedSection]];
        }   
    }   
    
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    
    if (NSNotFound == self.openedSection || index < self.openedSection) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }   
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    } 
    
    [tableView beginUpdates];
    [tableView insertRowsAtIndexPaths:inserts withRowAnimation:insertAnimation];
    [tableView deleteRowsAtIndexPaths:deletes withRowAnimation:deleteAnimation];
    [tableView endUpdates];
    
    self.openedSection = index;
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView sectionClosed:(NSInteger)index {
    
    SISection *section = [self.sections objectAtIndex:index];
    section.opened = NO;
    
    NSInteger total = [tableView numberOfRowsInSection:index];
    if (total > 0) {
        NSMutableArray *deletes = [NSMutableArray arrayWithCapacity:total];
        for (NSInteger row = 0; row < total; ++row) {
            [deletes addObject:[NSIndexPath indexPathForRow:row inSection:index]];
        }
        [tableView deleteRowsAtIndexPaths:deletes withRowAnimation:UITableViewRowAnimationTop];
    }        
    
    self.openedSection = NSNotFound;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resetSections {
    if (NSNotFound != self.openedSection) {
        SISection * section = [self.sections objectAtIndex:self.openedSection];
        section.opened = NO;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.openedSection];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        self.openedSection = NSNotFound;
    }
    [self.sections removeAllObjects];
}

@end
