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

#import "SIRevealController.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface SIRevealController ()
/**
 * Setup the controller for revealing with the following options:
 *  1) UIPanGestureRecognizer for both navigationBar & view.
 *  2) Reveal bar button item with common icon (left).
 *
 * NOTE if its parent view controller of its navigation controller has not
 * yet been setup for revealing (in ZUUIRevealController), do nothing.
 */
- (void)setupForReveal;
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface SIRevealMenuController : UITableViewController <NITableViewModelDelegate>

@property (nonatomic, readonly, retain) NSArray* menu;
@property (nonatomic, readonly, retain) NITableViewModel* model;

- (id)initWithMenu:(NSString *)menu;

@end



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIRevealController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithMainController:(UIViewController *)mainController menu:(NSString *)menu
{

    self.mainController = mainController;
    SIRevealMenuController* m = [[SIRevealMenuController alloc] initWithMenu:menu];
    self.menuController = [[UINavigationController alloc] initWithRootViewController:m];
    
    if ([self initWithFrontViewController:self.mainController
                       rearViewController:self.menuController]) {
        
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMainController:(UIViewController *)mainController {
    if ([mainController isKindOfClass:[UINavigationController class]]){
        self.mainController = (UINavigationController *) mainController;
    } else {
        self.mainController = [[UINavigationController alloc] initWithRootViewController:mainController];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setupForReveal {
//    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)]
//        && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)]) {
        /*
        UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self.navigationController.parentViewController
                                                        action:@selector(revealGesture:)];
        
        [self.navigationController.navigationBar addGestureRecognizer:panGestureRecognizer];
        [self.navigationController.view addGestureRecognizer:panGestureRecognizer];
        
        UIImage* menu = [UIImage imageWithPath:@"SiroccoUI.bundle/menu.png"];
        UIBarButtonItem* list = [[UIBarButtonItem alloc] initWithImage:menu
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self.navigationController.parentViewController
                                                                action:@selector(revealToggle:)];
        self.navigationItem.leftBarButtonItem = list;
//    }
         */
}

@end



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIRevealMenuController

@synthesize menu = _menu;
@synthesize model = _model;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithMenu:(NSString *)menu {
    if (self = [self initWithStyle:UITableViewStylePlain]) {
        _menu  = [NSArray arrayWithContentsOfFile:NIPathForBundleResource(nil, menu)];
        _model = [[NITableViewModel alloc] initWithSectionedArray:self.menu delegate:self];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self.model;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NITableViewModelDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableViewModel:(NITableViewModel *)tableViewModel
                   cellForTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath
                         withObject:(id)object {
    // A pretty standard implementation of creating table view cells follows.
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"row"];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"row"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [object objectForKey:@"name"];
    
    return cell;
    
}

@end