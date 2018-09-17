//这是自动生成的文件，不要修改，否则你的修改将被覆盖
#import "TestStateMachine.h"
@interface TestStateMachine () 
@property (assign,nonatomic) TestState state;
@end
@implementation TestStateMachine
- (instancetype)initWithState:(TestState)state {
    self = [super init];
    if (self) {
        _state = state;
        _shouldEnterCurrentStateWhenObserverChanged = YES;
    }
    return self;
}
- (instancetype)init {
    return [self initWithState:TestStateAcceptA];
}
- (void)setObserver:(id<TestObserver>)observer {
    BOOL obChanged = _observer != observer;
    _observer = observer;
    if (!self.shouldEnterCurrentStateWhenObserverChanged && obChanged) {
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
        case TestStateAcceptBEOF: {
            if ([obs respondsToSelector:@selector(onEnterAcceptBEOF:)]) {
                [obs onEnterAcceptBEOF:self];
            }
            break;
        }
        case TestStateFinish: {
            if ([obs respondsToSelector:@selector(onEnterFinish:)]) {
                [obs onEnterFinish:self];
            }
            break;
        }
        case TestStateAcceptA: {
            if ([obs respondsToSelector:@selector(onEnterAcceptA:)]) {
                [obs onEnterAcceptA:self];
            }
            break;
        }
        case TestStateAcceptAB: {
            if ([obs respondsToSelector:@selector(onEnterAcceptAB:)]) {
                [obs onEnterAcceptAB:self];
            }
            break;
        }
    }
}
- (void)doInputA {
    if (TestStateAcceptBEOF == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromAcceptBEOFToFaultWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromAcceptBEOFToFaultWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitAcceptBEOF:)]) {
                [self.observer onExitAcceptBEOF:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
        }
    }
    if (TestStateAcceptA == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromAcceptAToAcceptABWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromAcceptAToAcceptABWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitAcceptA:)]) {
                [self.observer onExitAcceptA:self];
            }
            self.state = TestStateAcceptAB;
            if ([self.observer respondsToSelector:@selector(onEnterAcceptAB:)]) {
                [self.observer onEnterAcceptAB:self];
            }
        }
    }
    if (TestStateAcceptAB == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromAcceptABToAcceptABWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromAcceptABToAcceptABWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitAcceptAB:)]) {
                [self.observer onExitAcceptAB:self];
            }
            self.state = TestStateAcceptAB;
            if ([self.observer respondsToSelector:@selector(onEnterAcceptAB:)]) {
                [self.observer onEnterAcceptAB:self];
            }
        }
    }
}
- (void)doInputB {
    if (TestStateAcceptBEOF == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromAcceptBEOFToAcceptBEOFWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromAcceptBEOFToAcceptBEOFWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitAcceptBEOF:)]) {
                [self.observer onExitAcceptBEOF:self];
            }
            self.state = TestStateAcceptBEOF;
            if ([self.observer respondsToSelector:@selector(onEnterAcceptBEOF:)]) {
                [self.observer onEnterAcceptBEOF:self];
            }
        }
    }
    if (TestStateAcceptA == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromAcceptAToFaultWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromAcceptAToFaultWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitAcceptA:)]) {
                [self.observer onExitAcceptA:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
        }
    }
    if (TestStateAcceptAB == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromAcceptABToAcceptBEOFWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromAcceptABToAcceptBEOFWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitAcceptAB:)]) {
                [self.observer onExitAcceptAB:self];
            }
            self.state = TestStateAcceptBEOF;
            if ([self.observer respondsToSelector:@selector(onEnterAcceptBEOF:)]) {
                [self.observer onEnterAcceptBEOF:self];
            }
        }
    }
}
- (void)doEOF {
    if (TestStateAcceptBEOF == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromAcceptBEOFToFinishWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromAcceptBEOFToFinishWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitAcceptBEOF:)]) {
                [self.observer onExitAcceptBEOF:self];
            }
            self.state = TestStateFinish;
            if ([self.observer respondsToSelector:@selector(onEnterFinish:)]) {
                [self.observer onEnterFinish:self];
            }
        }
    }
    if (TestStateAcceptAB == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromAcceptABToFaultWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromAcceptABToFaultWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitAcceptAB:)]) {
                [self.observer onExitAcceptAB:self];
            }
            self.state = TestStateFault;
            if ([self.observer respondsToSelector:@selector(onEnterFault:)]) {
                [self.observer onEnterFault:self];
            }
        }
    }
}
@end
