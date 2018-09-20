//这是自动生成的文件，不要修改，否则你的修改将被覆盖
#import <Foundation/Foundation.h>
@class TestStateMachine;
typedef NS_ENUM(NSUInteger, TestState) {
    TestStateAcceptA,
    TestStateAcceptAB,
    TestStateAcceptBEOF,
    TestStateFault,
    TestStateFinish,
};
@protocol TestObserver <NSObject>
@optional
- (void)onEnterAcceptA:(TestStateMachine *)stateMachine;
- (void)onExitAcceptA:(TestStateMachine *)stateMachine;
- (void)onEnterAcceptAB:(TestStateMachine *)stateMachine;
- (void)onExitAcceptAB:(TestStateMachine *)stateMachine;
- (void)onEnterAcceptBEOF:(TestStateMachine *)stateMachine;
- (void)onExitAcceptBEOF:(TestStateMachine *)stateMachine;
- (void)onEnterFault:(TestStateMachine *)stateMachine;
- (void)onExitFault:(TestStateMachine *)stateMachine;
- (void)onEnterFinish:(TestStateMachine *)stateMachine;
- (void)onExitFinish:(TestStateMachine *)stateMachine;
@end
@protocol TestDelegate <NSObject>
@optional
-(BOOL)shouldSM:(TestStateMachine *)stateMachine doEOFThenTransiteFrom:(TestState)from to:(TestState)to;
-(BOOL)shouldSM:(TestStateMachine *)stateMachine doInputAThenTransiteFrom:(TestState)from to:(TestState)to;
-(BOOL)shouldSM:(TestStateMachine *)stateMachine doInputBThenTransiteFrom:(TestState)from to:(TestState)to;
@end
@interface TestStateMachine: NSObject 
- (void)doEOF;
- (void)doInputA;
- (void)doInputB;
- (instancetype)initWithState:(TestState)state;
@property (assign,nonatomic,readonly) TestState state;
//default is YES
@property (assign,nonatomic) BOOL shouldEnterCurrentStateWhenObserverChanged;
@property (weak,nonatomic) id<TestObserver> observer;
@property (weak,nonatomic) id<TestDelegate> delegate;
@end
