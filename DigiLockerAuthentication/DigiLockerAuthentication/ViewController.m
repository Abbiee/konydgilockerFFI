//
//  ViewController.m
//  DigiLockerAuthentication
//
//  Created by Abbie on 04/02/21.
//

#import "ViewController.h"
#import "DigiLockerGeneric.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)clickAction:(id)sender {
   [ [DigiLockerGeneric sharedManager] launchNativeControllerOnKonyForm:@"https://api.digitallocker.gov.in/public/oauth2/1/authorize?response_type=code&client_id=C77A27DD&code_challenge=fc5f03742f9b004d8b6b9bba9e9478949205a251948ac8a5b4&&code_challenge_method=S256&redirect_uri=sbapp://com.sbi.sbfreedomplus.ios&state=anaswarasasidharan" titleName:@"Title"];
}


@end
