//
//  ThreeViewController.m
//  APPLaunchTest
//
//  Created by love on 2017/11/8.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "ThreeViewController.h"

//迷宫问题
/*
 0 1 0 1 0
 0 0 1 0 1
 0 0 0 1 1
 0 0 0 0 0
 0 1 0 0 0
 */

/*
 0 1 1 0
 0 0 0 0
 0 0 0 1
 1 0 0 0
 */

/*●问题描述：
 
 　　给出一个矩阵，其中0表示通路，1表示墙壁，这样就形成了一个迷宫，要求编写算法求出其中一条路径。
 ●递归思路：
 
 　　编写一个走迷宫函数，传入二位数组的下标，先假设该点位于最终路径上（将0置为2）再探测周围四个点是否可以走通（是否为０），如果可以走通则将该点四周能走通的点作为函数参数传入函数进入递归。若四周均不能走通（都不为０时）则将该点置回０表示该点不是最终路径上的点。
 　　在此思路中递归进入时表示了枚举路径，当发现此条路径走到某处再不能走通时就将路径该点置回０并且递归退出（回溯）寻找下一条可走通路径。
 */

#define END_I 4
#define ENG_J 4
#define START_I 0
#define START_J 0

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"应用中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 60)];
    label.text = @"见控制台";
    [label setTextAlignment:NSTextAlignmentCenter];
    label.center = self.view.center;
    [self.view addSubview:label];
    
    
    int i,j;
    int num = 0;//记录步数
    
    int maze[5][5] = {
        {0,0,1,0,1},
        {0,1,0,0,1},
        {0,0,1,0,1},
        {1,0,0,0,1},
        {0,0,1,0,0}
    };
    
    //打印迷宫
    printf("打印迷宫\n");
    
    for (i = 0; i<=6; i++) {
        printf("-");
    }
    printf("\n");
    
    for (i = 0; i<5; i++) {
        printf("|");
        
        for (j = 0; j<5; j++) {
           
            if (maze[i][j] == 1) {
                printf("@");
            }else{
                printf(" ");
            }
        }
        printf("|\n");
    }
    for (i = 0; i<=6; i++) {
        printf("-");
    }
    printf("\n");
    
    
    if (chatMaze(maze, 0, 0) == 0) {
        printf("没有通道");
    }else{
        printf("有通道\n");
    }

    
    for (int i = 0; i<=6; i++) {
        printf("-");
    }
    printf("\n");
    
    for (i = 0; i<5; i++) {
        printf("|");
        
        for (j = 0; j<5; j++) {
            if (maze[i][j] == 1) {
                printf("@");
            }else if (maze[i][j]==2){
                printf("^");
                num++;
            }else{
                printf(" ");
            }
        }
        printf("|\n");
        
    }

    for (int i = 0; i<=6; i++) {
        printf("-");
    }
    printf("\n");
    printf("共走了%d步",num);
    

}

int chatMaze(int maze[][5],int i,int j){
    
    int end = 0;
    
    //假设能走通
    maze[i][j] = 2;
    
    //如果出边界置为1
    if (i == END_I && j == ENG_J) {
        end = 1;
    }
    
    //如果没有走到终点则判断当前位置的右，下，左，上
    if (end != 1 && j+1 <= ENG_J && maze[i][j+1] == 0) {
        if (chatMaze(maze, i, j+1) == 1) {
            return 1;
        }
    }
    
    if (end != 1 && i+1 <= END_I && maze[i+1][j] == 0) {
        if (chatMaze(maze, i+1, j) == 1) {
            return 1;
        }
    }
    
    if (end != 1 && j - 1 >= START_J && maze[i][j-1] ==0) {
        if (chatMaze(maze, i, j-1) == 1) {
            return 1;
        }
    }
    
    if (end != 1 && i-1 >= START_I && maze[i-1][j] == 0) {
        if (chatMaze(maze, i-1, j) ==1) {
            return 1;
        }
    }
    
    
    
    //四周都走不通了置为0
    if (end != 1) {
        maze[i][j] = 0;
    }
    
    return end;
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
