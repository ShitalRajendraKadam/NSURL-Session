//
//  ViewController.m
//  IOS_NSURLSession
//
//  Created by Student P_02 on 13/06/18.
//  Copyright © 2018 Shital. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.NameArray=[[NSMutableArray alloc]init];
    NSString *str=@"https://api.github.com/repositories/19438/commits";
    NSURL *myurl=[NSURL URLWithString:str];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:myurl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //code
        NSHTTPURLResponse *myResponse=(NSHTTPURLResponse *)response;
        if(myResponse.statusCode==200)
        {
            NSLog(@"Response Found");
            if(data)
            {
                NSArray *myArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                
                
               // NSDictionary *Commit=[myArray valueForKey:@"commit"];

                //NSDictionary *Author=[Commit valueForKey:@"author"];
                
                for(NSDictionary *temp in myArray)
                {
                    NSDictionary *Commit=[temp valueForKey:@"commit"];
                    NSDictionary *Author=[Commit valueForKey:@"author"];

                    
                    NSString *Name=[Author valueForKey:@"name"];
                    
                   if(Name==(id)[NSNull null])
                  {
                       [self.NameArray addObject:@"Null"];
                    }
                    else
                    {
                    
                    
                    [self.NameArray addObject:Name];
                    
                    
                    }
                }


                
                if(error)
                {
                    NSLog(@"Error : %@ ",error.localizedDescription);
                }
                else
                {
                    NSLog(@"Name :%@",self.NameArray);
                    [self.myTableView reloadData];

                }
            }
            else
            {
                NSLog(@"Response not Found");

            }
        }
        
    }];
    [dataTask resume];
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.NameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];

    cell.textLabel.text=[self.NameArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
