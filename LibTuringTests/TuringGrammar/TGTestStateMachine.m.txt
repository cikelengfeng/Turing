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
    return [self initWithState:TestStateDark];
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
        case TestStateDark: {
            if ([obs respondsToSelector:@selector(onEnterDark:)]) {
                [obs onEnterDark:self];
            }
            break;
        }
        case TestStateLight: {
            if ([obs respondsToSelector:@selector(onEnterLight:)]) {
                [obs onEnterLight:self];
            }
            break;
        }
    }
}
- (void)doTurnOff {
    if (TestStateLight != self.state) {
        return;
    }
    BOOL shouldTransition = YES;
    if ([self.delegate respondsToSelector:@selector(shouldSM:doTurnOffThenTransiteFrom:to:)]) {
        shouldTransition = [self.delegate shouldSM:self doTurnOffThenTransiteFrom:self.state to:TestStateDark];
    }
    if (!shouldTransition) {
        return;
    }
    if ([self.observer respondsToSelector:@selector(onExitLight:)]) {
        [self.observer onExitLight:self];
    }
    self.state = TestStateDark;
    if ([self.observer respondsToSelector:@selector(onEnterDark:)]) {
        [self.observer onEnterDark:self];
    }
}
- (void)doTurnOn {
    if (TestStateDark != self.state) {
        return;
    }
    BOOL shouldTransition = YES;
    if ([self.delegate respondsToSelector:@selector(shouldSM:doTurnOnThenTransiteFrom:to:)]) {
        shouldTransition = [self.delegate shouldSM:self doTurnOnThenTransiteFrom:self.state to:TestStateLight];
    }
    if (!shouldTransition) {
        return;
    }
    if ([self.observer respondsToSelector:@selector(onExitDark:)]) {
        [self.observer onExitDark:self];
    }
    self.state = TestStateLight;
    if ([self.observer respondsToSelector:@selector(onEnterLight:)]) {
        [self.observer onEnterLight:self];
    }
}
@end
