//
//  OpenTableViewController2.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TableViewHeader.h"
#ifdef CJTESTPOD
#import "CJSectionDataModel.h"
#else
#import <CJBaseUtil/CJSectionDataModel.h> //在CJDataUtil中
#endif

#import "MyOpenTableView.h"


//实际只需采用CJTableViewHeaderFooterView和CJSectionDataModel即可实现
@interface OpenTableViewController2 : UIViewController {
    
}
@property (nonatomic, strong) IBOutlet MyOpenTableView *openTableView;
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *sectionModels;

@end
