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


#import "NSObject+SiroccoCore.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
NI_FIX_CATEGORY_BUG(NSObject_SiroccoCore)


@implementation NSObject (SiroccoCore)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    objc_removeAssociatedObjects(self);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) className {
    return NSStringFromClass([self class]);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)execute:(SEL)selector, ... {
    va_list vargs;
    va_start(vargs, selector);
    id result = [self execute:selector retainArguments:NO vargs:vargs];
    va_end(vargs);
    return result;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)execute:(SEL)selector retainArguments:(BOOL)retainArguments, ... {
	va_list vargs;
    va_start(vargs, retainArguments);
    id result = [self execute:selector retainArguments:retainArguments vargs:vargs];
    va_end(vargs);
    return result;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)execute:(SEL)selector retainArguments:(BOOL)retainArguments vargs:(va_list)vargs {
    if (! [self respondsToSelector:selector]) return nil;
    
    char* args = (char*) vargs;
    
	NSMethodSignature* signature = [self methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    if (retainArguments) [invocation retainArguments];
    
	for (int index = 2; index < [signature numberOfArguments]; index++) {
        const char *type = [signature getArgumentTypeAtIndex:index];
		NSUInteger size, align;
        NSGetSizeAndAlignment(type, &size, &align);
        NSUInteger mod = (NSUInteger)args % align;
        if (mod != 0) {
            args += (align - mod);
        }
        [invocation setArgument:args atIndex:index];
        args += size;
    }
    
    [invocation invoke];
    if ([signature methodReturnLength]) {
        id result;
        [invocation getReturnValue:&result];
        return result;
    }
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)getAssociatedObjectForKey:(const void *)key 
{
    return objc_getAssociatedObject(self, key);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAssociatedObject:(id)value forKey:(const void *)key 
{
    // reject the same value update to avoid memory leak.
    if (value == [self getAssociatedObjectForKey:key]) {
        return;
    } else {
        // clear previous value first.
        objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);    
    }
    
    if ([value conformsToProtocol:@protocol(NSCopying)]) {
        
        objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
    } else if ([value conformsToProtocol:@protocol(NSObject)]) {
        
        objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    } else {
        
        objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
        
    }
}

@end
