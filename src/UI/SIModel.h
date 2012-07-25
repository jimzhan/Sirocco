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


@interface SIModel : NSObject {
    WeakRef id<NIOperationDelegate> _delegate;
}

@property (nonatomic, readwrite, assign) id<NIOperationDelegate> delegate;

#pragma mark - Operations status
/**
 * Operation Queue & relative statuses for table to process data.
 */
// flag to indicate if the operation has been performed once.
@property (nonatomic, readonly, getter=isLoaded) BOOL loaded;
// NSOperation statuses.
@property (nonatomic, readonly, getter=isReady)     BOOL ready;
@property (nonatomic, readonly, getter=isCancelled) BOOL cancelled;
@property (nonatomic, readonly, getter=isExecuting) BOOL executing;
@property (nonatomic, readonly, getter=isFinished)  BOOL finished;

- (void)load:(NIOperation *)operation;

@end