//
//  DigiLockerAuthController.m
//  DigiLockerAuthentication
//
//  Created by SBI on 04/02/21.
//

#import "DigiLockerAuthController.h"
#import <WebKit/WebKit.h>

@interface DigiLockerAuthController ()<WKNavigationDelegate,WKUIDelegate>{
    WKWebView *_digiLockerWeb;
    }

@end

@implementation DigiLockerAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_digiLockerWeb = [[WKWebView alloc] initWithFrame:CGRectMake(0,[UIApplication sharedApplication].statusBarFrame.size.height + 50, self.view.frame.size.width, self.view.frame.size.height -([UIApplication sharedApplication].statusBarFrame.size.height+70))];
        [self->_digiLockerWeb setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
    NSURL *url = [NSURL URLWithString: self.digiLockerURL];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
        self->_digiLockerWeb.UIDelegate = self;
        self->_digiLockerWeb.navigationDelegate = self;
            NSLog(@"Product URL%@", self.digiLockerURL);
        NSLog(@"TItle%@", self->_titleName);
        [self->_digiLockerWeb loadRequest:urlReq];
        [self.view addSubview:self->_digiLockerWeb];
     // do work here
    });
}


-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UINavigationBar *myNav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,  [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, 50)];
    [[UINavigationBar appearance] setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
     [UIColor whiteColor], NSForegroundColorAttributeName,
     [UIFont fontWithName:@"ArialMT" size:16.0], NSFontAttributeName,nil]];
    [myNav setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
   //[UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed: 0.40 green: 0.16 blue: 0.51 alpha: 1.00];
    
    [self.view addSubview:myNav];

    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backButtonClicked)];

    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:_titleName];
    
    navigItem.leftBarButtonItem = cancelItem;
    myNav.items = [NSArray arrayWithObjects: navigItem,nil];

    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
}

- (void)backButtonClicked {
    NSLog(@"Executing backButtonClicked...");
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 
 Asks the delegate for permission to navigate to new content based on the specified action information.
 
 webView
 The web view from which the navigation request began.
 
 navigationAction
 Details about the action that triggered the navigation request.
 
 decisionHandler
 A completion handler block to call with the results about whether to allow or cancel the navigation. This handler has no return value and takes the following parameter:
 
 policy
 A constant that indicates whether to cancel or allow the navigation. For a list of possible values, see WKNavigationActionPolicy.
 
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = navigationAction.request.URL;
    NSLog(@"Captured URL String %@", url);
    NSString *myScheme = @"sbapp";
    NSLog(@"URL SCHEME Passed %@", url.scheme);
    if ([url.scheme isEqualToString:myScheme] &&
      [app canOpenURL:url]) {
        NSLog(@"Yes it is same");
        NSString *redirectURL = url.absoluteString;
        [self sendResult:redirectURL];
        [self dismissViewControllerAnimated: YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    } else if ([url.scheme isEqualToString:myScheme] &&
               ![app canOpenURL:url]) {
        NSLog(@"This app is not allowed to query for scheme sbapp");
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
    
- (NSString *)getQueryComponentWithName:(NSString *)name  fromURL:(NSURL *)url{

NSString *component = nil;
if (url) {
    NSString *query = url.query;

    NSMutableDictionary *queryStringDictionary = [NSMutableDictionary dictionary];
    NSArray *urlComponents = [query componentsSeparatedByString:@"&"];

    for (NSString *keyValuePair in urlComponents){

        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];

        [queryStringDictionary setObject:value forKey:key];
    }

    component = [queryStringDictionary objectForKey:name];
}

return component;
}

// Passing value to the custom delegate

-(void) sendResult:(NSString*) result
{
    [_dlDelegate lockerResult:result];
}

@end
