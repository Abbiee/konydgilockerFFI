//
//  DigiLockerAuthController.h
//  DigiLockerAuthentication
//
//  Created by SBI on 04/02/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DigiLockerDelegate
-(void) lockerResult:(NSString*) smsInterfaceResult;
@end

@interface DigiLockerAuthController : UIViewController
@property (strong, nonatomic) NSString *digiLockerURL;
@property (strong, nonatomic) NSString *titleName;
@property (assign, nonatomic) id<DigiLockerDelegate> dlDelegate;
@end

NS_ASSUME_NONNULL_END
