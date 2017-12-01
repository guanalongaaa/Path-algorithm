//
//  ViewController.m
//  Test2017(1)(guanal)
//
//  Created by love on 2017/11/22.
//  Copyright © 2017年 guanal. All rights reserved.
//


#define ROWS 4
#define COLS 4

#import "ViewController.h"
#import "ThreeViewController.h"

@interface ViewController ()

@property (nonatomic , strong) UILabel * titleLabel; //content展示

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self showbutton];
    [self showLabel]; //加载label
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 44, self.view.frame.size.width-20, 200)];
//    label.center = self.view.center;
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentJustified];
    label.numberOfLines = 0;
    label.text = @"【问题描述】: 给出一个矩阵，从左上角开始走，只能向右或者向下，所有数字累加就是路径和，求出其中最小路径。";
    [self.view addSubview:label];
    
    
    
    //原始矩阵
    int i,j;
    int data[4][4] = {
        {1,3,5,9},
        {8,1,3,4},
        {5,0,6,1},
        {8,8,4,0}
    };
    
    
    //打印出矩阵
    printf("矩阵:\n");
    for(i = 0; i <= 10; i++){
      printf("-");
    }
    printf("\n");
    
    for (i = 0; i < 4; i++){
        printf("|");
        for (j = 0; j < 4; j++){
            
            printf("%d ", data[i][j]);
            
        }
        printf("|\n");
    }
    
    for(i = 0; i <= 10; i++){
         printf("-");
    }
    printf("\n");
    
    
    int num = minPathSum(data,0,0);
    printf("最小路径和%d\n",num);

    self.titleLabel.text = [NSString stringWithFormat:@"需要走6步,最小路径之和为%d\n",num];
    
    int tt =uniquePaths(4, 4);
    printf("走法%d\n",tt);
    
}

//走法
int uniquePaths(int m, int n)
{
    int N = n + m - 2;
    int K = n - 1;
    double res = 1.0;
    for (int i = 1; i <= n - 1; i++)
    {
        res = res * (N - K + i) / i;
    }
    return (int)res;
}

/*
 【问题描述】: 给出一个矩阵，从左上角开始走，只能向右或者向下，所有数字累加就是路径和，求出其中最小路径。
 
  思路：只允许向右或者向下走 所以开始计算时当前s[i][j]只可能从s[i-1][j]+data[i][j]或者s[i][j-1]+data[i][j]计算得到
  也就是s[i][j] = min(s[i-1][j],s[i][j-1])+ data[i][j] 即需要比较s[i-1][j],s[i][j-1])
  
  因为第一行没有s[i-1][j]元素，只有s[i][j-1]元素。
  第一列没有s[i][j-1]元素，只有s[i-1][j]元素。
  需要特殊处理

 */

int minPathSum(int data[][4],int i,int j)
{
    //获取行数和列数
    int rows = ROWS;
    int cols = COLS;
    //第一列
    for (int i = 1; i < rows; i++)
    {
        data[i][0] = data[i - 1][0] + data[i][0];
    }
    //第一行
    for (int i = 1; i < cols; i++)
    {
        data[0][i] = data[0][i - 1] + data[0][i];
    }
    //非第一行和第一列的元素
    for (int i = 1; i < rows; i++)
    {
        for (int j = 1; j < cols; j++)
        {
            if (data[i][j-1] > data[i-1][j]) {
                
                data[i][j] = data[i - 1][j] + data[i][j];
            }else{
                data[i][j] = data[i][j - 1] + data[i][j];
            }
        }
    }
    

    printf("求和结果矩阵:\n");
    for(i = 0; i <= 13; i++){
        printf("-");
    }
    printf("\n");
    for (i = 0; i < 4; i++){
        printf("|");
        for (j = 0; j < 4; j++){
            printf("%2d ", data[i][j]);
        }
        printf("|\n");
    }
    for(i = 0; i <= 13; i++){
        printf("-");
    }
    printf("\n");
    
    
    printf("最优路径坐标倒推:\n");
    int rowt = 3;
    int colt = 3;
    for (int i = 0; i  < 7; i++) {
        printf("(%d,%d)\n",rowt,colt);
        if(data[rowt-1][colt] < data[rowt][colt-1]){
            rowt--;
        }
        else{
            colt--;
        }
    }
    printf("最优路径坐标正推:\n");
    int g = 0;
    int k = 0;
    for (int j = 0; j<7; j++) {
        printf("{%d,%d}",g,k);
        if (data[g][k+1] < data[g+1][k]) {
            k++;
        }else{
            g++;
        }
        
    }
    printf("\n");
    
    //返回最短路径值
    return data[rows - 1][cols - 1];
    
}

-(void)showLabel{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 60)];
    label.center = self.view.center;
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.text = @"最小路径之和--";
    self.titleLabel = label;
    [self.view addSubview:self.titleLabel];
    
}

-(void)showbutton{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 60);
    button.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    button.layer.cornerRadius = 7;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"跳转迷宫" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

-(void)buttonClick:(UIButton *)sender{
    
    ThreeViewController * firstVC = [[ThreeViewController alloc]init];
    firstVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:firstVC animated:YES];
    
}



@end
