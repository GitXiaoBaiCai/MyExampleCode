//
//  SQL_VC.m
//  MyCode
//
//  Created by New_iMac on 2021/7/8.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "SQL_VC.h"
#import <sqlite3.h>

@interface SQL_VC (){
    sqlite3 *_db;
}

@end

@implementation SQL_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatSubBtns];
    
    [self creatDatabase];

    
}

// 打开或创建数据库
-(void)creatDatabase{
    // 获取一个路径
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"student.db"];
    NSLog(@"%@",fileName);
    
      //db代表整个数据库、db是数据库实例
    
    // 打开(创建)数据库，(如果路径不存在数据库会自动创建)
    int result = sqlite3_open(fileName.UTF8String, &_db);
    if (SQLITE_OK == result) {
        NSLog(@"数据库打开(创建成功)");
        // 创建一个表 如果不存在 t_student (id integer类型 主键自增长, ... , ...)
        const char *sql = "create table if not exists t_student (id integer primary key autoincrement, name text, age integer);";
        char *errorMesage = NULL;
        int result_exec = sqlite3_exec(_db, sql, NULL, NULL, &errorMesage);
        if (SQLITE_OK == result_exec) {
            NSLog(@"建表成功");
        }else{
            NSLog(@"建表失败：%s",errorMesage);
        }
    }else{
        NSLog(@"打开数据库失败");
    }
}


-(void)creatSubBtns{
    NSArray *functionName = @[@"插入数据",
                              @"更新数据",
                              @"删除数据",
                              @"",
                              @"",
                              @"",
                              @"",
                              @"",
                              @"",
                              @""];
    
    for (int i=0; i<functionName.count; i++) {
        NSString *title = functionName[i];
        if (!title||title.length<1) { break; }
        UIButton *button = [UIButton title:functionName[i] titColorN:color_white font:font_s(15) bgColor:color_theme];
        AddTarget_for_button(button, clickBtn:)
        [button cornerRadius:25];
        button.tag = i+1;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(navc_bar_h+30+(i/2)*70);
            make.width.offset(150); make.height.offset(50);
            if (i%2==0) {
                make.right.equalTo(self.view.mas_centerX).offset(-10);
            }else{
                make.left.equalTo(self.view.mas_centerX).offset(10);
            }
        }];
    }
}

// 执行一条SQL语句(非查询时使用)
-(int)mc_sqlite3_exec:(const char*)sql{
    char *errorMesage = NULL;
    int result_exec = sqlite3_exec(_db, sql, NULL, NULL, &errorMesage);
    if (SQLITE_OK == result_exec) {
        NSLog(@"SQL执行成功");
    }else{
        NSLog(@"SQL执行失败：%s",errorMesage);
    }
    return result_exec;
}


-(void)clickBtn:(UIButton*)btn{
    switch (btn.tag) {
        case 1:{ [self insertData]; } break;
            
        case 2:{
            
        } break;
            
        case 3:{
            
        } break;
            
        case 4:{
            
        } break;
                                    
        default:
            break;
    }
}

-(void)insertData{
    for (int i=0; i<20; i++) {
        NSString *strSql = FORMATSTR(@"insert into t_student (name, age) values(\"张%d\",\"%d\");",i,i+10);
        const char *sql = strSql.UTF8String;
        [self mc_sqlite3_exec:sql];
    }
}



-(void)query{
    // SQL注入漏洞
    
    /**
     登录功能
     
     1.用户输入账号和密码
     * 账号：123' or 1 = 1 or '' = '
     * 密码：456654679
     
     2.拿到用户输入的账号和密码去数据库查询（查询有没有这个用户名和密码）
     select * from t_user where username = '123' and password = '456';
     
     
     select * from t_user where username = '123' and password = '456';
     */
    
    // 1.定义sql语句
    const char *sql = "select id, name, age from t_student where name = ?;";
    
    // 2.定义一个stmt存放结果集
    sqlite3_stmt *stmt = NULL;
    
    // 3.检测SQL语句的合法性
    int result = sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"查询语句是合法的");
        
        // 设置占位符的内容
        sqlite3_bind_text(stmt, 1, "jack", -1, NULL);
        
        // 4.执行SQL语句，从结果集中取出数据
//        int stepResult = sqlite3_step(stmt);
        while (sqlite3_step(stmt) == SQLITE_ROW) { // 真的查询到一行数据
            // 获得这行对应的数据
            
            // 获得第0列的id
            int sid = sqlite3_column_int(stmt, 0);
            
            // 获得第1列的name
            const unsigned char *sname = sqlite3_column_text(stmt, 1);
            
            // 获得第2列的age
            int sage = sqlite3_column_int(stmt, 2);
            
            NSLog(@"%d %s %d", sid, sname, sage);
        }
    } else {
        NSLog(@"查询语句非合法");
    }
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
