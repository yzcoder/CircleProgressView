# CircleProgressView

环形的进度条，可以自己定制大小、宽度、动画时间、完成比例`(0 ~ 1)`等属性.


	      
***	           
	           
####可以实现如下效果

![](https://raw.githubusercontent.com/yzcoder/CircleProgressView/master/CircleViewDemo/IMG_5029.PNG)

####或
![](https://raw.githubusercontent.com/yzcoder/CircleProgressView/master/CircleViewDemo/FullSizeRender.jpg)



###使用方法
```
    /**< 创建进度条视图*/
    YzCircleView  *circle = [YzCircleView prograssWithFrame:CGRectMake(100, 100, 200, 200) duration:5];
    /**< 添加到父视图*/
    [self.view addSubview:circle];
    
    /**< 设置可选属性*/
    circle.progressScale = 0.8;
    circle.startAngle = 0;
    circle.endAngle = 270;
    circle.trackLineWidth = 3;
    circle.progressLineWidth = 2;
    circle.trackColor = [UIColor grayColor];
    circle.progressColor = [UIColor orangeColor];

```
属性详细说明请参见代码

