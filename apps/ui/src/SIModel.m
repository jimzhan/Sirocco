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


#import "SIModel.h"


NSInteger const kSIMaxConcurrentOperations = 2;
///////////////////////////////////////////////////////////////////////////////////////////////////
// Private
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface SIModel ()
@property (nonatomic, readwrite, retain) NSDate* loadedDate;
@property (nonatomic, readwrite, retain) NSOperationQueue* queue;
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIModel

@synthesize loadedDate;
@synthesize queue     = _queue;
@synthesize delegate  = _delegate;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_queue cancelAllOperations];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    if (self = [super init]) {
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = kSIMaxConcurrentOperations;
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded {
    return self.finished && self.loadedDate;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isCancelled {
    return [self.queue.operations all:^(id item) { 
        return [NSNumber numberWithBool:[(NSOperation *)item isCancelled]]; 
    }];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isExecuting {
    return [self.queue.operations any:^(id item) { 
        return [NSNumber numberWithBool:[(NSOperation *)item isExecuting]]; 
    }];    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// Flag to indicate the real finish status, 
// as the NSOperation::isFinished does not
// actually reflect it's finished, it can be True
// from the very beginning even without any operation activated.
- (BOOL)isFinished {
    return [self.queue.operations all:^(id item) { 
        return [NSNumber numberWithBool:[(NSOperation *)item isFinished]]; 
    }];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isReady {
    return [self.queue.operations all:^(id item) { 
        return [NSNumber numberWithBool:[(NSOperation *)item isReady]]; 
    }];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(NIOperation *)operation {
    NIDASSERT(self.delegate);
    
    [operation setDelegate:self.delegate];

    WeakRef SIModel* ME = self;
    // NOTE that both operation blocks & delegate's methods 
    // will be called by NIOperation, the delegate's methods go first.
    if (operation.didFinishBlock) {
        NIBasicBlock didFinishBlock = operation.didFinishBlock;
        operation.didFinishBlock = ^(NIOperation* op) {
            ME.loadedDate = [NSDate date];
            didFinishBlock(op);
        };
    } else {
        operation.didFinishBlock = ^(NIOperation* op) {
            ME.loadedDate = [NSDate date];
        };
    }
    
    [self.queue addOperation:operation];
}

@end
