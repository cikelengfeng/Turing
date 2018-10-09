#import "TestStateMachine.h"
@interface TestStateMachine () 
@property (assign,nonatomic,readwrite) TestState state;
@property (strong,nonatomic,readwrite) NSMutableArray<NSString *> * stack;
@end
@implementation TestStateMachine
- (instancetype)initWithState:(TestState)state {
    self = [super init];
    if (self) {
        _state = state;
        _shouldEnterCurrentStateWhenObserverChanged = YES;
        _stack = [NSMutableArray array];
        [_stack addObject:@"$"];
    }
    return self;
}
- (instancetype)init {
    return [self initWithState:TestStateS0];
}
- (void)setObserver:(id<TestObserver>)observer {
    BOOL obChanged = _observer != observer;
    _observer = observer;
    if (self.shouldEnterCurrentStateWhenObserverChanged && obChanged) {
        [self notifyObserverEnterCurrentState:_observer];
    }
}
- (void)notifyObserverEnterCurrentState:(id<TestObserver>)obs {
    switch (self.state) {
        case TestStateFault: {
            if ([obs respondsToSelector:@selector(onEnterFault:)]) {
                [obs onEnterFault:self];
            }
            break;
        }
        case TestStateFinish: {
            if ([obs respondsToSelector:@selector(onEnterFinish:)]) {
                [obs onEnterFinish:self];
            }
            break;
        }
        case TestStateS0: {
            if ([obs respondsToSelector:@selector(onEnterS0:)]) {
                [obs onEnterS0:self];
            }
            break;
        }
        case TestStateS1: {
            if ([obs respondsToSelector:@selector(onEnterS1:)]) {
                [obs onEnterS1:self];
            }
            break;
        }
        case TestStateS2: {
            if ([obs respondsToSelector:@selector(onEnterS2:)]) {
                [obs onEnterS2:self];
            }
            break;
        }
    }
}
- (BOOL)checkStackTop:(NSString *)element {
    return [self.stack.lastObject isEqualToString:element];
}
- (void)pushStackWithElement:(NSString *)element {
    [self.stack addObject:element];
}
- (void)popStack {
    [self.stack removeLastObject];
}
- (void)doA {
    if (TestStateS0 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldSM:doAThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doAThenTransiteFrom:self.state to:TestStateS1];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS0:)]) {
                [self.observer onExitS0:self];
            }
            [self pushStackWithElement:@"P"];
            self.state = TestStateS1;
            if ([self.observer respondsToSelector:@selector(onEnterS1:)]) {
                [self.observer onEnterS1:self];
            }
            return;
        }
    }
    if (TestStateS1 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldSM:doAThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doAThenTransiteFrom:self.state to:TestStateS1];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS1:)]) {
                [self.observer onExitS1:self];
            }
            [self pushStackWithElement:@"P"];
            self.state = TestStateS1;
            if ([self.observer respondsToSelector:@selector(onEnterS1:)]) {
                [self.observer onEnterS1:self];
            }
            return;
        }
    }
    if (TestStateS2 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldSM:doAThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doAThenTransiteFrom:self.state to:TestStateFault];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS2:)]) {
                [self.observer onExitS2:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
            return;
        }
    }
}
- (void)doB {
    if (TestStateS0 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldSM:doBThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doBThenTransiteFrom:self.state to:TestStateFault];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS0:)]) {
                [self.observer onExitS0:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
            return;
        }
    }
    if (TestStateS1 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldSM:doBThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doBThenTransiteFrom:self.state to:TestStateS2];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS1:)]) {
                [self.observer onExitS1:self];
            }
            [self popStack];
            self.state = TestStateS2;
            if ([self.observer respondsToSelector:@selector(onEnterS2:)]) {
                [self.observer onEnterS2:self];
            }
            return;
        }
    }
    if (TestStateS2 == self.state) {
        BOOL shouldTransition = [self checkStackTop:@"$"];
        if ([self.delegate respondsToSelector:@selector(shouldSM:doBThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doBThenTransiteFrom:self.state to:TestStateFault];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS2:)]) {
                [self.observer onExitS2:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
            return;
        }
    }
    if (TestStateS2 == self.state) {
        BOOL shouldTransition = [self checkStackTop:@"P"];
        if ([self.delegate respondsToSelector:@selector(shouldSM:doBThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doBThenTransiteFrom:self.state to:TestStateS2];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS2:)]) {
                [self.observer onExitS2:self];
            }
            [self popStack];
            self.state = TestStateS2;
            if ([self.observer respondsToSelector:@selector(onEnterS2:)]) {
                [self.observer onEnterS2:self];
            }
            return;
        }
    }
}
- (void)doEOF {
    if (TestStateS0 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldSM:doEOFThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doEOFThenTransiteFrom:self.state to:TestStateFault];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS0:)]) {
                [self.observer onExitS0:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
            return;
        }
    }
    if (TestStateS1 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldSM:doEOFThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doEOFThenTransiteFrom:self.state to:TestStateFault];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS1:)]) {
                [self.observer onExitS1:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
            return;
        }
    }
    if (TestStateS2 == self.state) {
        BOOL shouldTransition = [self checkStackTop:@"P"];
        if ([self.delegate respondsToSelector:@selector(shouldSM:doEOFThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doEOFThenTransiteFrom:self.state to:TestStateFault];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS2:)]) {
                [self.observer onExitS2:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
            return;
        }
    }
    if (TestStateS2 == self.state) {
        BOOL shouldTransition = [self checkStackTop:@"$"];
        if ([self.delegate respondsToSelector:@selector(shouldSM:doEOFThenTransiteFrom:to:)]) {
            shouldTransition = [self.delegate shouldSM:self doEOFThenTransiteFrom:self.state to:TestStateFinish];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitS2:)]) {
                [self.observer onExitS2:self];
            }
            self.state = TestStateFinish;
            if ([self.observer respondsToSelector:@selector(onEnterFinish:)]) {
                [self.observer onEnterFinish:self];
            }
            return;
        }
    }
}
@end
