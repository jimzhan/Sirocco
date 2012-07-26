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


#import "SISection.h"

#import "SIAppearance.h"
#import "UIImage+SiroccoUI.h"


static NSString * const kReusableID = @"Section";



@interface SISection ()
@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readwrite, retain) UIButton *disclosure;
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SISection

@dynamic tableView;
@synthesize disclosure = _disclosure;

@synthesize opened;
@synthesize index;
@synthesize view = _view;
@synthesize rows;
@synthesize delegate = _delegate;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    if (self = [super init]) {

    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)toggleOpen:(id)sender {
    [self toggleOpenWithUserAction:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableView *)tableView {
    NSAssert([self.delegate respondsToSelector:@selector(tableView)], @"tableView property missing");
    return [(UITableViewController *)self.delegate tableView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIButton *)disclosure {
    if (! _disclosure) {
        NSString *path = [SIAppearance pathForContainer:[UITableView class] control:@"disclosure"];
        _disclosure = [UIButton buttonWithType:UIButtonTypeCustom];
        _disclosure.frame = CGRectMake(0, 0, 26, 26);
        [_disclosure setImage:[UIImage imageWithPath:path] forState:UIControlStateNormal];
        [_disclosure setImage:[UIImage imageWithPath:path forState:UIControlStateSelected] 
                     forState:UIControlStateSelected];
    }
    return _disclosure;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDelegate:(UIViewController<SISectionViewDelegate> *)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
        
        self.disclosure.selected = NO;
        self.view.accessoryView = self.disclosure;        
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)view {
    if (! _view) {
        _view = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:kReusableID];
        [_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                            action:@selector(toggleOpen:)]];
        
        _view.userInteractionEnabled = YES;
        _view.textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        _view.textLabel.backgroundColor = [UIColor clearColor];
        _view.detailTextLabel.backgroundColor = [UIColor clearColor];    
    }
    return _view;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)toggleOpenWithUserAction:(BOOL)userAction {
    self.disclosure.selected = !self.disclosure.selected;
    
    if (userAction) {
        if (self.disclosure.selected) {
            [self.delegate tableView:self.tableView sectionOpened:index];
        } else {
            [self.delegate tableView:self.tableView sectionClosed:index];
        }
    }
}

@end