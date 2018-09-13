#import "TestStateMachine.h"
@interface TestStateMachine()
@property (assign, nonatomic) TestState state;
@property (assign, nonatomic) BOOL transitionOcurred;
@end
@implementation TestStateMachine
- (instancetype)init {
    self = [super init];
    if (self) {
        _state = TestStateDark;
        _transitionOcurred = NO;
    }
    return self;
}
- (void)setObserver:(id<TestObserver>)observer {
    BOOL obChanged = _observer != observer;
    _observer = observer;
    if (!self.transitionOcurred && obChanged) {
        if ([self.observer respondsToSelector:@selector(onEnterDark:)]) {
            [self.observer onEnterDark:self];
        }
    }
}
- (void)setState:(TestState)state {
    _state = state;
    self.transitionOcurred = YES;
}
- (void)doSmash {
    if (TestStateLight2 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromLight2ToFinishWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromLight2ToFinishWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitLight2:)]) {
                [self.observer onExitLight2:self];
            }
            self.state = TestStateFinish;
            if ([self.observer respondsToSelector:@selector(onEnterFinish:)]) {
                [self.observer onEnterFinish:self];
            }
        }
    }
    if (TestStateLight1 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromLight1ToFinishWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromLight1ToFinishWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitLight1:)]) {
                [self.observer onExitLight1:self];
            }
            self.state = TestStateFinish;
            if ([self.observer respondsToSelector:@selector(onEnterFinish:)]) {
                [self.observer onEnterFinish:self];
            }
        }
    }
    if (TestStateDark == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromDarkToFinishWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromDarkToFinishWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitDark:)]) {
                [self.observer onExitDark:self];
            }
            self.state = TestStateFinish;
            if ([self.observer respondsToSelector:@selector(onEnterFinish:)]) {
                [self.observer onEnterFinish:self];
            }
        }
    }
}
- (void)doTurnOff {
    if (TestStateLight2 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromLight2ToDarkWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromLight2ToDarkWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitLight2:)]) {
                [self.observer onExitLight2:self];
            }
            self.state = TestStateDark;
            if ([self.observer respondsToSelector:@selector(onEnterDark:)]) {
                [self.observer onEnterDark:self];
            }
        }
    }
    if (TestStateLight1 == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromLight1ToDarkWithStateMachine:)]) {
            shouldTransition = [self.delegate shouldTransiteFromLight1ToDarkWithStateMachine:self ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitLight1:)]) {
                [self.observer onExitLight1:self];
            }
            self.state = TestStateDark;
            if ([self.observer respondsToSelector:@selector(onEnterDark:)]) {
                [self.observer onEnterDark:self];
            }
        }
    }
}
- (void)doTurnOnWithp1:( NSString *)p1 p2:( NSNumber *)p2  {
    if (TestStateDark == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromDarkToLight2WithStateMachine:p1:p2:)]) {
            shouldTransition = [self.delegate shouldTransiteFromDarkToLight2WithStateMachine:self p1:p1 p2:p2 ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitDark:)]) {
                [self.observer onExitDark:self];
            }
            self.state = TestStateLight2;
            if ([self.observer respondsToSelector:@selector(onEnterLight2:)]) {
                [self.observer onEnterLight2:self];
            }
        }
    }
    if (TestStateDark == self.state) {
        BOOL shouldTransition = YES;
        if ([self.delegate respondsToSelector:@selector(shouldTransiteFromDarkToLight1WithStateMachine:p1:p2:)]) {
            shouldTransition = [self.delegate shouldTransiteFromDarkToLight1WithStateMachine:self p1:p1 p2:p2 ];
        }
        if (shouldTransition) {
            if ([self.observer respondsToSelector:@selector(onExitDark:)]) {
                [self.observer onExitDark:self];
            }
            self.state = TestStateLight1;
            if ([self.observer respondsToSelector:@selector(onEnterLight1:)]) {
                [self.observer onEnterLight1:self];
            }
        }
    }
}
@end
