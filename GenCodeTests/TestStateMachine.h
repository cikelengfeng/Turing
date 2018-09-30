#import <Foundation/Foundation.h>
@class TestStateMachine;
typedef NS_ENUM(NSUInteger, TestState) {
    TestStateFault,
    TestStateFinish,
    TestStateS0,
    TestStateS1,
    TestStateS2,
};
@protocol TestObserver <NSObject>
@optional
- (void)onEnterFault:(TestStateMachine *)stateMachine;
- (void)onExitFault:(TestStateMachine *)stateMachine;
- (void)onEnterFinish:(TestStateMachine *)stateMachine;
- (void)onExitFinish:(TestStateMachine *)stateMachine;
- (void)onEnterS0:(TestStateMachine *)stateMachine;
- (void)onExitS0:(TestStateMachine *)stateMachine;
- (void)onEnterS1:(TestStateMachine *)stateMachine;
- (void)onExitS1:(TestStateMachine *)stateMachine;
- (void)onEnterS2:(TestStateMachine *)stateMachine;
- (void)onExitS2:(TestStateMachine *)stateMachine;
@end
@protocol TestDelegate <NSObject>
@optional
-(BOOL)shouldSM:(TestStateMachine *)stateMachine doAThenTransiteFrom:(TestState)from to:(TestState)to;
-(BOOL)shouldSM:(TestStateMachine *)stateMachine doBThenTransiteFrom:(TestState)from to:(TestState)to;
-(BOOL)shouldSM:(TestStateMachine *)stateMachine doEOFThenTransiteFrom:(TestState)from to:(TestState)to;
@end
@interface TestStateMachine: NSObject 
- (void)doA;
- (void)doB;
- (void)doEOF;
- (instancetype)initWithState:(TestState)state;
@property (assign,nonatomic,readonly) TestState state;
//default is YES
@property (assign,nonatomic,readwrite) BOOL shouldEnterCurrentStateWhenObserverChanged;
@property (weak,nonatomic,readwrite) id<TestObserver> observer;
@property (weak,nonatomic,readwrite) id<TestDelegate> delegate;
@end
