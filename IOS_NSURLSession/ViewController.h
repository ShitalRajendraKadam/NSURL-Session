//
//  ViewController.h
//  IOS_NSURLSession
//
//  Created by Student P_02 on 13/06/18.
//  Copyright © 2018 Shital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property NSMutableArray *NameArray;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

