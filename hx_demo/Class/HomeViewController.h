//
//  HomeViewController.h
//  CustomerSystem-ios
//
//  Created by dhc on 15/2/13.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EaseMob.h"

static NSString *g_appkey = nil;
static NSString *g_cname = nil;

@interface HomeViewController : UIViewController
{
    EMConnectionState _connectionState;
}

@end
