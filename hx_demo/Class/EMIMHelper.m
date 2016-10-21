//
//  EMIMHelper.m
//  CustomerSystem-ios
//
//  Created by dhc on 15/3/28.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "EMIMHelper.h"

#import "EaseMob.h"
#import "LocalDefine.h"

static EMIMHelper *helper = nil;

@implementation EMIMHelper

@synthesize appkey = _appkey;
@synthesize cname = _cname;
@synthesize nickname = _nickname;

@synthesize username = _username;
@synthesize password = _password;

- (instancetype)init
{
    self = [super init];
    if (self) {
        //固定的
        _appkey = @"1314520ff#kefu";
        _cname = @"zhangs";
//        _nickname = [userDefaults objectForKey:kCustomerNickname];
//        if ([_nickname length] == 0) {
//            _nickname = @"";
//            [userDefaults setObject:_nickname forKey:kCustomerNickname];
//        }
//        
//        _tenantId = [userDefaults objectForKey:kCustomerTenantId];
//        if ([_tenantId length] == 0) {
//            _tenantId = @"";
//            [userDefaults setObject:_tenantId forKey:kCustomerTenantId];
//        }
//        
//        _projectId = [userDefaults objectForKey:kCustomerProjectId];
//        if ([_projectId length] == 0) {
//            _projectId = @"";
//            [userDefaults setObject:_projectId forKey:kCustomerProjectId];
//        }
        
//        _username = [userDefaults objectForKey:@"username"];
//        _password = [userDefaults objectForKey:@"password"];
    }
    
    return self;
}

+ (instancetype)defaultHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[EMIMHelper alloc] init];
    });
    
    return helper;
}

#pragma mark - login

- (void)loginEasemobSDK
{
    EaseMob *easemob = [EaseMob sharedInstance];
    if (![easemob.chatManager isLoggedIn] || ([_username length] == 0 || [_password length] == 0)) {
        if ([_username length] == 0 || [_password length] == 0) {
            //自己的账号密码
            _username = @"12532136217362";
            _password = @"123456";
            //_password = @"sun521";
            [easemob.chatManager asyncRegisterNewAccount:_username password:_password withCompletion:^(NSString *username, NSString *password, EMError *error) {
                if (!error || error.errorCode == EMErrorServerDuplicatedAccount) {
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:@"username" forKey:_username];
                    [userDefaults setObject:@"password" forKey:_password];
                    [userDefaults synchronize];
                    [easemob.chatManager asyncLoginWithUsername:_username password:_password];
                }
            } onQueue:nil];
        }
        else{
            [easemob.chatManager asyncLoginWithUsername:_username password:_password];
        }
    }
}

#pragma mark - info

//- (void)setNickname:(NSString *)nickname
//{
//    if ([nickname length] > 0 && ![nickname isEqualToString:_nickname]) {
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:nickname forKey:kCustomerNickname];
//        _nickname = nickname;
//    }
//}

- (void)setCname:(NSString *)cname
{
    if ([cname length] > 0 && ![cname isEqualToString:_cname]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:cname forKey:kCustomerName];
        _cname = cname;
    }
}

//- (void)setProjectId:(NSString *)projectId
//{
//    if ([projectId length] > 0 && ![projectId isEqualToString:_projectId]) {
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:projectId forKey:kCustomerProjectId];
//        _projectId = [projectId copy];
//    }
//}
//
//- (void)setTenantId:(NSString *)tenantId
//{
//    if ([tenantId length] > 0 && ![tenantId isEqualToString:_tenantId]) {
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:tenantId forKey:kCustomerTenantId];
//        _tenantId = [tenantId copy];
//    }
//}
@end
