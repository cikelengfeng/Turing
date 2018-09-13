#import <Foundation/Foundation.h>
@class TestStateMachine;
@protocol TestObserver <NSObject>
@optional
-(void)onEnterLight2:(TestStateMachine *)Test;
-(void)onExitLight2:(TestStateMachine *)Test;
-(void)onEnterLight1:(TestStateMachine *)Test;
-(void)onExitLight1:(TestStateMachine *)Test;
-(void)onEnterFinish:(TestStateMachine *)Test;
-(void)onExitFinish:(TestStateMachine *)Test;
-(void)onEnterDark:(TestStateMachine *)Test;
-(void)onExitDark:(TestStateMachine *)Test;
@end
@protocol TestDelegate <NSObject>
@optional
-(BOOL)shouldTransiteFromLight2ToFinishWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromLight2ToDarkWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromLight1ToFinishWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromLight1ToDarkWithStateMachine:(TestStateMachine *)stateMachine ;
-(BOOL)shouldTransiteFromDarkToLight2WithStateMachine:(TestStateMachine *)stateMachine p1:( NSString *)p1 p2:( NSNumber *)p2 ;
-(BOOL)shouldTransiteFromDarkToLight1WithStateMachine:(TestStateMachine *)stateMachine p1:( NSString *)p1 p2:( NSNumber *)p2 ;
-(BOOL)shouldTransiteFromDarkToFinishWithStateMachine:(TestStateMachine *)stateMachine ;
@end
typedef NS_ENUM(NSUInteger, TestState) {
    TestStateLight2,
    TestStateLight1,
    TestStateFinish,
    TestStateDark,
};
@interface TestStateMachine: NSObject
- (void)doSmash;
- (void)doTurnOff;
- (void)doTurnOnWithp1:( NSString *)p1 p2:( NSNumber *)p2 ;
@property (assign, nonatomic, readonly) TestState state;
@property (weak, nonatomic) id<TestObserver> observer;
@property (weak, nonatomic) id<TestDelegate> delegate;
@end
