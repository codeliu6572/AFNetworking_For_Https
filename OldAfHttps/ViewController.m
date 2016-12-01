//
//  ViewController.m
//  OldAfHttps
//
//  Created by 刘浩浩 on 2016/11/29.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *url = @"xxxxxxxxxx";
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2设置https 请求
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    mgr.securityPolicy = securityPolicy;
    // 3.发送POST请求
    
    [mgr POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"responseObject: %@", responseObject);

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);

    }];
    
    
    
}

+ (AFSecurityPolicy*)customSecurityPolicy

{
    
    // /先导入证书
    //在这加证书，一般情况适用于单项认证
    //    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"igoda" ofType:@"cer"];//证书的路径
    //
    //    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    //    if (ISNULL(certData)) {
    //        return nil;
    //    }
    // AFSSLPinningModeCertificate 使用证书验证模式
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    
    // 如果是需要验证自建证书，需要设置为YES
    
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    
    //如置为NO，建议自己添加对应域名的校验逻辑。
    
    securityPolicy.validatesDomainName = NO;
    
    //    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
