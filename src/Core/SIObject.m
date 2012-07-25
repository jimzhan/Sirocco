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


#import "SIObject.h"

#import "NSObject+SiroccoCore.h"


@interface SIObject ()
//@property (nonatomic, readonly, retain) NILinkedList* list;
@property (nonatomic, readonly, retain) NSMutableDictionary* data;
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SIObject

@synthesize ID   = _ID;
@synthesize data = _data;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_data removeAllObjects];
    _data = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init { 
    NIDERROR(@"Use initWithID: instead");
    NIDASSERT(NO); 
    return nil; 
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// TODO initWithFormat or concate???
- (id)initWithID:(NSString *)ID, ... {
    if (self = [super init]) {
        va_list vargs;
        va_start(vargs, ID);
        _ID = [[NSString alloc] initWithFormat:ID arguments:vargs];
        va_end(vargs);    
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private properties

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableDictionary *)data {
    if (! _data) {
        _data = [NSMutableDictionary dictionary];
    }
    return _data;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %@>", self.className, self.ID];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSFastEnumeration

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state 
                                  objects:(WeakRef id [])buffer 
                                    count:(NSUInteger)len {
    return [self.data countByEnumeratingWithState:state objects:buffer count:len];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectForKey:(NSString *)key {
    return [self.data objectForKey:key];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)popForKey:(NSString *)key {
    id object = [self objectForKey:key];
    [self setObject:nil forKey:key];
    return object;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object forKey:(NSString *)key {
    [self.data setObject:object forKey:key];
}

@end
