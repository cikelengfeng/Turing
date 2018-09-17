//
//  main.m
//  GenCodeTests
//
//  Created by 徐 东 on 2018/9/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestStateMachine.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSString *input = @"bbbb";
        
        TestStateMachine *sm = [[TestStateMachine alloc] init];
        
        NSUInteger len = [input length];
        unichar buffer[len];
        [input getCharacters:buffer range:NSMakeRange(0, len)];
        
        for(int i = 0; i < len; ++i) {
            char current = buffer[i];
            if (current == 'a') {
                [sm doInputA];
            } else if (current == 'b') {
                [sm doInputB];
            } else {
                [sm doEOF];
            }
        }
        [sm doEOF];
        if (sm.state == TestStateFault) {
            NSLog(@"%@ is not a+b+", input);
        }
        if (sm.state == TestStateFinish) {
            NSLog(@"%@ is a+b+", input);
        }
    }
    return 0;
}
