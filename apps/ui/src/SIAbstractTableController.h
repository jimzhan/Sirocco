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

#import "UITableView+SiroccoUI.h"



/**
 * Generic abstract table view controller with
 * drag & refresh (by EGORefreshTableHeader) support.
 *
 *  NOTE that this class does not directly create &
 *  add the table view (SITableView). Subclass MUST
 *  create SITableView instance by overriding tableView
 *  property & implement the corresponding loadView methods.
 */
@interface SIAbstractTableController : UIViewController<
UITableViewDelegate,
NIOperationDelegate,
EGORefreshTableHeaderDelegate> {

    UITableView* _tableView;
}

//@property (nonatomic, readonly,  retain) SIActivityView* activity;
@property (nonatomic, readonly,  retain) UITableView* tableView;
@property (nonatomic, readonly,  assign) UITableViewStyle tableViewStyle;
@property (nonatomic, readwrite, assign) BOOL clearsSelectionOnViewWillAppear;


- (id)initWithStyle:(UITableViewStyle)style;

@end