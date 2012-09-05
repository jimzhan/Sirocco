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


#if NS_BLOCKS_AVAILABLE

// Most Generic block with Argument & returned Value support.
typedef id (^SIBlock)(id object);

// Argument block without returned value, for processing data mainly.
typedef void (^SIABlock)(id object);

// Block with returned value that does not accept argument, for generating data mainly.
typedef id  (^SIVBlock)(void);

#endif