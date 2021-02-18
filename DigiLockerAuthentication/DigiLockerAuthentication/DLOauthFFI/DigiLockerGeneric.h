//
//  DigiLockerGeneric.h
//  DigiLockerAuthentication
//
//  Created by SBI on 04/02/21.
//

#import <Foundation/Foundation.h>
#import "DigiLockerAuthController.h"
#import "lglobals.h"

NS_ASSUME_NONNULL_BEGIN

@interface DigiLockerGeneric : NSObject<DigiLockerDelegate>
@property (nonatomic, retain) CallBack *callbackObj;

+ (id)sharedManager;
- (void)withCallBack:(CallBack*)callBack launchNativeControllerOnKonyForm:(NSString*)webURL titleName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
