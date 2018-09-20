//
//  main.m
//  GenCodeTests
//
//  Created by 徐 东 on 2018/9/13.
//  Copyright © 2018 dx lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestStateMachine.h"

static NSString *StackSymbolP = @"p";
static NSString *StackSymbolS = @"$";

//@interface Test : NSObject<TestDelegate>
//
//@property (nonatomic, strong) NSMutableArray<NSString *> *stack;
//
//@end
//
//@implementation Test
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _stack = [NSMutableArray new];
//        [_stack addObject:StackSymbolS];
//    }
//    return self;
//}
//
//- (NSString *)stackTop
//{
//    return [self.stack lastObject];
//}
//
//- (void)pushStack:(NSString *)sb
//{
//    [self.stack addObject:sb];
//}
//
//- (NSString *)popStack
//{
//    NSString *top = [self.stack lastObject];
//    [self.stack removeLastObject];
//    return top;
//}
//
//- (BOOL)shouldSM:(TestStateMachine *)stateMachine doEOFThenTransiteFrom:(TestState)from to:(TestState)to
//{
//    if (from == TestStateS2 && to == TestStateFault) {
//        return [self stackTop] == StackSymbolP;
//    }
//
//    if (from == TestStateS2 && to == TestStateFinish) {
//        return [self stackTop] == StackSymbolS;
//    }
//    return YES;
//}
//
//- (BOOL)shouldSM:(TestStateMachine *)stateMachine doAThenTransiteFrom:(TestState)from to:(TestState)to
//{
//    if (((from == TestStateS0 || from == TestStateS1) && to == TestStateS1)) {
//        [self pushStack:StackSymbolP];
//    }
//    return YES;
//}
//
//- (BOOL)shouldSM:(TestStateMachine *)stateMachine doBThenTransiteFrom:(TestState)from to:(TestState)to
//{
//    if ((from == TestStateS1 && to == TestStateS2)) {
//        [self popStack];
//    }
//    if (from == TestStateS2 && to == TestStateS2) {
//        if ([self stackTop] == StackSymbolP) {
//            [self popStack];
//        } else {
//            return NO;
//        }
//    }
//    if (from == TestStateS2 && to == TestStateFault) {
//        return [self stackTop] == StackSymbolS;
//    }
//    return YES;
//}
//
//@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        NSString *input = @"baba";
//
//        TestStateMachine *sm = [[TestStateMachine alloc] init];
//        Test *delegate = [Test new];
//        sm.delegate = delegate;
//
//        NSUInteger len = [input length];
//        unichar buffer[len];
//        [input getCharacters:buffer range:NSMakeRange(0, len)];
//
//        for(int i = 0; i < len; ++i) {
//            char current = buffer[i];
//            if (current == 'a') {
//                [sm doA];
//            } else if (current == 'b') {
//                [sm doB];
//            } else {
//                [sm doEOF];
//            }
//        }
//        [sm doEOF];
//        switch (sm.state) {
//            case TestStateFault:
//                NSLog(@"%@ is not a^nb^n", input);
//                break;
//            case TestStateFinish:
//                NSLog(@"%@ is a^nb^n", input);
//                break;
//            default:
//                NSLog(@"FATAL");
//                break;
//        }
    }
    return 0;
}
