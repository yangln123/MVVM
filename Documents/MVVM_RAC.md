#iOS MVVM之ReactiveCocoa

## MVVM简介
开发中使用较为频繁的设计模式MVC
![](./images/MVC_detail.png)
MVVM设计模式
![](./images/MVVM_detail.png)


## ReactiveCocoa简介
是一个基于函数响应式编程思想（Funcation Reactive Programming，简称FRP）的框架
![](./images/functionCode.png)   

框架由几个重要组成部分：

* 1.信号：RACSignal,可以被订阅，订阅后可以进行逻辑处理或者数据传递
* 2.订阅者：RACSubscriber，用于订阅和发送数据，是一个协议，由具体的类实现
* 3.清理者：RACDisposable，用于取消或者清理订阅者的资源
* 4.RACSubject：可以当成一个信号，也可以充当信号发送者


## MVVM为什么要结合ReactiveCocoa



结合RAC的MVVM设计模式
![](./images/MVVMReactiveCocoa.png)


## ReactiveCocoa导入
* 一般不直接使用 pod 'ReactiveCocoa'，会下载安装swift相关的库
* 安装使用 pod 'ReactiveObjC', :git => 'https://github.com/ReactiveCocoa/ReactiveObjC'


## 结论
* MVM固然古老，在小型项目中非常实用
* MVVM虽然很强大，有时候会增加一定的代码量
* 在实际开发中，不拘泥于某种架构，或者将二者结合使用，才是正确的做法

## Demo



##参考文献
https://www.raywenderlich.com/2346-mvvm-tutorial-with-reactivecocoa-part-1-2

https://www.jianshu.com/p/a898ef83f38c

https://www.jianshu.com/p/763278ee047f

https://www.jianshu.com/p/35a28cf0a22f

https://www.jianshu.com/p/14075b5ec5ff

