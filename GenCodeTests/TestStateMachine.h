//这是自动生成的文件，不要修改，否则你的修改将被覆盖
#import <Foundation/Foundation.h>
@class TestStateMachine;
@protocol TestObserver <NSObject>
@optional
- (void)onEnterFault:(TestStateMachine*)stateMachine;
- (void)onExitFault:(TestStateMachine*)stateMachine;
- (void)onEnterAcceptBEOF:(TestStateMachine*)stateMachine;
- (void)onExitAcceptBEOF:(TestStateMachine*)stateMachine;
- (void)onEnterFinish:(TestStateMachine*)stateMachine;
- (void)onExitFinish:(TestStateMachine*)stateMachine;
- (void)onEnterAcceptA:(TestStateMachine*)stateMachine;
- (void)onExitAcceptA:(TestStateMachine*)stateMachine;
- (void)onEnterAcceptAB:(TestStateMachine*)stateMachine;
- (void)onExitAcceptAB:(TestStateMachine*)stateMachine;
@end
@protocol TestDelegate <NSObject>
@optional
-(BOOL)shouldTransiteFromAcceptBEOFToFaultWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromAcceptBEOFToAcceptBEOFWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromAcceptBEOFToFinishWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromAcceptAToFaultWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromAcceptAToAcceptABWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromAcceptABToFaultWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromAcceptABToAcceptBEOFWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromAcceptABToAcceptABWithStateMachine:(TestStateMachine *)stateMachine ;
@end
typedef NS_ENUM(NSUInteger, TestState) {
    TestStateFault,
    TestStateAcceptBEOF,
    TestStateFinish,
    TestStateAcceptA,
    TestStateAcceptAB,
};
@interface TestStateMachine: NSObject 
- (void)doInputA;
- (void)doInputB;
- (void)doEOF;
- (instancetype)initWithState:(TestState)state;
@property (assign,nonatomic,readonly) TestState state;
//default is YES
@property (assign,nonatomic) BOOL shouldEnterCurrentStateWhenObserverChanged;
@property (weak,nonatomic) id<TestObserver> observer;
@property (weak,nonatomic) id<TestDelegate> delegate;
@end
