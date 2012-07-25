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


#import <Foundation/Foundation.h>



@protocol SISectionViewDelegate <NSObject>
- (void)tableView:(UITableView *)tableView sectionClosed:(NSInteger)index;
- (void)tableView:(UITableView *)tableView sectionOpened:(NSInteger)index;
@end



@interface SISection : NSObject

@property (nonatomic, readwrite, assign) BOOL opened;
@property (nonatomic, readwrite, assign) NSInteger index;

@property (nonatomic, readonly,  retain) UITableViewCell *view;
@property (nonatomic, readwrite, retain) NSMutableArray *rows;
@property (nonatomic, readwrite, retain) UIViewController<SISectionViewDelegate> * delegate;

- (void)toggleOpenWithUserAction:(BOOL)userAction;

@end

