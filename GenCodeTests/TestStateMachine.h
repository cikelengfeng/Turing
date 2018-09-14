//这是自动生成的文件，不要修改，否则你的修改将被覆盖
#import <Foundation/Foundation.h>
@class TestStateMachine;
@protocol TestObserver <NSObject>
@optional
-(void)onEnterDark:(TestStateMachine *)stateMachine;
-(void)onExitDark:(TestStateMachine *)stateMachine;
-(void)onEnterLight1:(TestStateMachine *)stateMachine;
-(void)onExitLight1:(TestStateMachine *)stateMachine;
-(void)onEnterFinish:(TestStateMachine *)stateMachine;
-(void)onExitFinish:(TestStateMachine *)stateMachine;
-(void)onEnterLight2:(TestStateMachine *)stateMachine;
-(void)onExitLight2:(TestStateMachine *)stateMachine;
@end
@protocol TestDelegate <NSObject>
@optional
-(BOOL)shouldTransiteFromDarkToLight1WithStateMachine:(TestStateMachine *)stateMachine p1:( NSString *)p1 p2:( NSNumber *)p2 ;
-(BOOL)shouldTransiteFromDarkToFinishWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromDarkToLight2WithStateMachine:(TestStateMachine *)stateMachine p1:( NSString *)p1 p2:( NSNumber *)p2 ;
-(BOOL)shouldTransiteFromLight1ToDarkWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromLight1ToFinishWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromLight2ToDarkWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromLight2ToFinishWithStateMachine:(TestStateMachine *)stateMachine ;
@end
typedef NS_ENUM(NSUInteger, TestState) {
    TestStateDark,
    TestStateLight1,
    TestStateFinish,
    TestStateLight2,
};
@interface TestStateMachine: NSObject
- (void)doTurnOff;
- (void)doTurnOnWithp1:( NSString *)p1 p2:( NSNumber *)p2 ;
- (void)doSmash;
@property (assign, nonatomic, readonly) TestState state;
@property (assign, nonatomic) BOOL shouldEnterCurrentStateWhenObserverChanged;//default is YES
@property (weak, nonatomic) id<TestObserver> observer;
@property (weak, nonatomic) id<TestDelegate> delegate;
@end
