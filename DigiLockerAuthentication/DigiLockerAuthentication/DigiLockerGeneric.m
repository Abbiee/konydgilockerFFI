//
//  DigiLockerGeneric.m
//  DigiLockerAuthentication
//
//  Created by SBI on 04/02/21.
//

#import "DigiLockerGeneric.h"
#import "DigiLockerAuthController.h"

@implementation DigiLockerGeneric

+ (id)sharedManager {
    static DigiLockerGeneric *sharedMyManager = nil;
        sharedMyManager = [[self alloc] init];
    return sharedMyManager;
}

- (void)launchNativeControllerOnKonyForm:(NSString*)webURL titleName:(NSString*)name{
    DigiLockerAuthController *authView = [[DigiLockerAuthController alloc]init];
    authView.digiLockerURL = webURL;
    authView.titleName = name;
    authView.dlDelegate = self;
    UIWindow *window =  [[[UIApplication sharedApplication] windows] firstObject];
    UIViewController *vc = [window rootViewController];
////    UINavigationController *navController = (UINavigationController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
////    [navController pushViewController:webview animated:YES];
    [vc presentViewController:authView animated:YES completion:nil];
   
    
    
//   dispatch_async(dispatch_get_main_queue(), ^{
//
//        // Call UI related operations
//
//        [KonyUIContext onCurrentFormControllerPresentModalViewController:authView animated:YES];
//
//    }
//    );
}

-(void) lockerResult:(NSString*) digiLockerResult
{
  NSArray * result = [[NSArray alloc] initWithObjects:digiLockerResult, nil];
 // executeClosure(self.callbackObj, result, NO);
  NSLog(@"Delegate Result %@", digiLockerResult);
}

@end
