#import <Foundation/Foundation.h>
@class TestStateMachine;
typedef NS_ENUM(NSUInteger, TestState) {
    TestStateDark,
    TestStateLight,
};
@protocol TestObserver <NSObject>
@optional
- (void)onEnterDark:(TestStateMachine *)stateMachine;
- (void)onExitDark:(TestStateMachine *)stateMachine;
- (void)onEnterLight:(TestStateMachine *)stateMachine;
- (void)onExitLight:(TestStateMachine *)stateMachine;
@end
@protocol TestDelegate <NSObject>
@optional
-(BOOL)shouldSM:(TestStateMachine *)stateMachine doTurnOffThenTransiteFrom:(TestState)from to:(TestState)to;
-(BOOL)shouldSM:(TestStateMachine *)stateMachine doTurnOnThenTransiteFrom:(TestState)from to:(TestState)to;
@end
@interface TestStateMachine: NSObject 
- (void)doTurnOff;
- (void)doTurnOn;
- (instancetype)initWithState:(TestState)state;
@property (assign,nonatomic,readonly) TestState state;
//default is YES
@property (assign,nonatomic) BOOL shouldEnterCurrentStateWhenObserverChanged;
@property (weak,nonatomic) id<TestObserver> observer;
@property (weak,nonatomic) id<TestDelegate> delegate;
@end
