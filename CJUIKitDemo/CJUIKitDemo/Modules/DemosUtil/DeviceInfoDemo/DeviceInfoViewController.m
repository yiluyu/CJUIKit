//
//  DeviceInfoViewController.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DeviceInfoViewController.h"

#import "DeviceCJHelper.h"
#import "DeviceInfo.h"


typedef NS_ENUM(NSUInteger, CJFileSizeUnitType) {
    CJFileSizeUnitTypeBestUnit,
    CJFileSizeUnitTypeB,
    CJFileSizeUnitTypeKB,
    CJFileSizeUnitTypeMB,
    CJFileSizeUnitTypeGB
};


@interface DeviceInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DeviceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"DeviceInfo", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //电池
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"电池电量";
        
        CGFloat batteryQuantity = [DeviceCJHelper getBatteryQuantity];
        info.value = [NSString stringWithFormat:@"%.2f%%", -batteryQuantity*100];
        
        [array addObject:info];
    }
    
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"电池状态";
        
        UIDeviceBatteryState batteryStauts = [DeviceCJHelper getBatteryStauts];
        NSArray *batteryStautsArray = @[@"UIDeviceBatteryStateUnknown",
                                        @"UIDeviceBatteryStateUnplugged",   // on battery, discharging
                                        @"UIDeviceBatteryStateCharging",    // plugged in, less than 100%
                                        @"UIDeviceBatteryStateFull",        // plugged in, at 100%
                                        ];
        info.value = [NSString stringWithFormat:@"%@", batteryStautsArray[batteryStauts]];
        
        [array addObject:info];
    }
    
    //当前屏幕亮度
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"屏幕亮度";
        // [iOS(OC)—仿支付宝我的二维码页面系统亮度调整](https://blog.csdn.net/Boyqicheng/article/details/78330250)
        
        CGFloat currentScreenBrightness = [DeviceCJHelper getScreenBrightness];
        info.value = [NSString stringWithFormat:@"%.2f%%", currentScreenBrightness*100];
        
        [array addObject:info];
    }
    
    //内存 & 磁盘
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"总内存大小";
        
        CGFloat totalMemorySize = [DeviceCJHelper getTotalMemorySize];
        info.value = [DeviceInfoViewController showFileSize:totalMemorySize unitType:CJFileSizeUnitTypeMB];
        
        [array addObject:info];
    }
    
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"未使用的内存";
        
        CGFloat availableMemorySize = [DeviceCJHelper getAvailableMemorySize];
        info.value = [DeviceInfoViewController showFileSize:availableMemorySize unitType:CJFileSizeUnitTypeMB];
        
        [array addObject:info];
    }
    
    
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"已使用的内存";
        
        CGFloat usedMemory = [DeviceCJHelper getUsedMemory];
        info.value = [DeviceInfoViewController showFileSize:usedMemory unitType:CJFileSizeUnitTypeMB];
        
        [array addObject:info];
    }
    
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"总磁盘容量";
        
        CGFloat totalDiskSize = [DeviceCJHelper getTotalDiskSize];
        info.value = [DeviceInfoViewController showFileSize:totalDiskSize unitType:CJFileSizeUnitTypeMB];
        
        [array addObject:info];
    }
    
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"未使用的磁盘容量";
        
        CGFloat availableDiskSize = [DeviceCJHelper getAvailableDiskSize];
        info.value = [DeviceInfoViewController showFileSize:availableDiskSize unitType:CJFileSizeUnitTypeMB];
        
        [array addObject:info];
    }
    
    //设备型号
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"设备型号";
        
        NSString *deviceType = [DeviceCJHelper getCurrentDeviceName];
        info.value = [NSString stringWithFormat:@"%@", deviceType];
        
        [array addObject:info];
    }
    
    //IP & WIFI
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"IP地址";
        
        NSString *IPAddress = [DeviceCJHelper getIPAddress];
        info.value = [NSString stringWithFormat:@"%@", IPAddress];
        
        [array addObject:info];
    }
    
    {
        DeviceInfo *info = [[DeviceInfo alloc] init];
        info.title = @"WIFI名称";
        
        NSString *WifiName = [DeviceCJHelper getWifiName];
        info.value = [NSString stringWithFormat:@"%@", WifiName];
        
        [array addObject:info];
    }
    
    self.array = array;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeviceInfo *info = [self.array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd.%@", indexPath.row+1, info.title];
    cell.detailTextLabel.text = info.value;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %zd %zd", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



/** 详见CJFileManager+CalculateFileSize.h */
+ (NSString *)showFileSize:(NSInteger)fileSize unitType:(CJFileSizeUnitType)fileSizeUnitType {
    NSString *fileSizeString = @"";
    
    switch (fileSizeUnitType) {
        case CJFileSizeUnitTypeBestUnit:
        {
            if (fileSize >= pow(10, 9)) { // size >= 1GB
                fileSizeString = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(10, 9)];
                
            } else if (fileSize >= pow(10, 6)) { // 1GB > size >= 1MB
                fileSizeString = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(10, 6)];
                
            } else if (fileSize >= pow(10, 3)) { // 1MB > size >= 1KB
                fileSizeString = [NSString stringWithFormat:@"%.2fKB", fileSize / pow(10, 3)];
                
            } else { // 1KB > size
                fileSizeString = [NSString stringWithFormat:@"%zdB", fileSize];
            }
            break;
        }
        case CJFileSizeUnitTypeB:
        {
            fileSizeString = [NSString stringWithFormat:@"%zdB", fileSize];
            break;
        }
        case CJFileSizeUnitTypeKB:
        {
            fileSizeString = [NSString stringWithFormat:@"%.2fKB", fileSize / pow(10, 3)];
            break;
        }
        case CJFileSizeUnitTypeMB:
        {
            fileSizeString = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(10, 6)];
            break;
        }
        case CJFileSizeUnitTypeGB:
        {
            fileSizeString = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(10, 9)];
            break;
        }
        default:
        {
            break;
        }
    }
    
    return fileSizeString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
