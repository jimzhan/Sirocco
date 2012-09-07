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
#import "UIImage+SiroccoUI.h"

#import "NimbusCore.h"
#import "NimbusModels.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface SIRevealController ()

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface SIRevealMenuController : UITableViewController <NITableViewModelDelegate>

@property (nonatomic, readonly, retain) NITableViewModel* model;

- (id)initWithSource:(NSString *)source;

@end



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIRevealController

@synthesize mainController = _mainController;
@synthesize menuController = _menuController;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithMainController:(UIViewController *)mainController menu:(NSString *)menu {
    self.mainController = mainController;
    self.menuController = [[SIRevealMenuController alloc] initWithSource:menu];
        
    if ([self initWithFrontViewController:self.mainController
                       rearViewController:self.menuController]) {
        
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Setup the controller for revealing with the following options:
 *  1) UIPanGestureRecognizer for both navigationBar & view.
 *  2) Reveal bar button item with common icon (left).
 *
 * NOTE if its parent view controller of its navigation controller has not
 * yet been setup for revealing (in ZUUIRevealController), do nothing.
 */
- (void)setMainController:(UIViewController *)mainController {
    if (_mainController == mainController) return;

    if ([mainController isKindOfClass:[UINavigationController class]]) {
        _mainController = mainController;
    } else {
        _mainController = [[UINavigationController alloc] initWithRootViewController:mainController];
    }
    
    //********** regular reveal button **********/
    UIImage* revealIcon = [UIImage imageWithPath:SIROCCO_UI_REVEAL];
    UIBarButtonItem* reveal= [[UIBarButtonItem alloc] initWithImage:revealIcon
                                                              style:UIBarButtonItemStylePlain 
                                                             target:self 
                                                             action:@selector(revealToggle:)];
    mainController.navigationItem.leftBarButtonItem = reveal;

    //********** Pan Gesture for view & navigation bar **********/
    UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(revealGesture:)];
    
    [mainController.navigationController.navigationBar addGestureRecognizer:recognizer];
    [mainController.navigationController.view addGestureRecognizer:recognizer];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setMenuController:(UIViewController *)menuController {
    if (_menuController == menuController) return;
    _menuController = [[UINavigationController alloc] initWithRootViewController:menuController];
}

@end



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIRevealMenuController


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSource:(NSString *)source {
    if (self = [self initWithStyle:UITableViewStylePlain]) {
        NSArray* menu = [NSArray arrayWithContentsOfFile:NIPathForBundleResource(nil, source)];
        _model = [[NITableViewModel alloc] initWithSectionedArray:menu delegate:self];
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
