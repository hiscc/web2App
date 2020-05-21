## 基础组件

类似与 HTML 中的标签系统在 App 开发内所有的组件以「类」的形式存在。这些类暴露出很多方法与属性，我们通过设置相关的属性，调用方法来自定义组件。

在 iOS 和 Android 中都实现了拖拽式的编程方式，我们可以直接把需要的组件拖拽到视图中，然后设置一些约束，属性。对于一些逻辑操作，我们可以在相应的「控制器」文件内取得到这些组件的引用，然后通过编程方式进行控制。控制器相当于 Web 中一个页面内的 JS 文件，其中的变量控制着页面的属性，方法对应着页面中的操作。

当然，在 App 开发中我们也可以直接在「控制器」内创建组件，完全跳过 Android 中的 XML 视图布局文件和 iOS 中的 storyboard 来构建视图「就像纯 JS 的 Web 应用的所有元素都在 JS 中创建」。这样会节省出很多视图编译的时间，但对于大部分项目来说构建 UI 的时间会加长。 

### 视图控制器

在 App 开发内部，一般来说一个视图控制器对应着一个页面「Android 中是一个 activity 类，iOS 中是一个 ViewController」。所有的页面元素和相关逻辑都可以在这个控制器文件内完成。当然这里存在一个总的控制器来控制监听应用的状态，监听你目前在哪个页面操作。在 Android 中是类似 Application.java 这样文件，在 iOS 中是 AppDelegate.swift 文件。它们用来监听整个应用的状态并执行相应的操作。

更加深入的解释，iOS 推荐 [iOS 官方文档](https://developer.apple.com/documentation/uikit/)，Android 推荐 [Android 官方文档](https://developer.android.com/)，里面对于视图和组件都有详尽的解释。



#### Android 页面路由

在 Android 中我们通过在 AndroidManifest.xml 文件中引用所有页面来注册路由，添加 App 权限、服务。只有在 AndroidManifest 中注册过的页面才可以被 App 显示，通过在某个 activity 中调用相应的方法来完成页面的切换，这样就实现了 App 的路由。

#### iOS 页面路由

在 iOS 中，我们通过指定相应的 UIViewController 来完成路由的跳转，我们通过在 main.storyboard 中构建所有 storyboard 来注册所有页面，每个 storyboard 对应有相应的 UIViewController ，然后把 storyboard 中相应的元素通过 Interface Builder 设置引用到 UIViewController 内完成对相关元素的自定义。

**对于任何继承了 UIViewController 的类来说，这个类就已经代表着一个页面了，无论它有没有被关联到 storyboard。如果没有被关联到 storyboard，我们也可以通过实例化它来取得这个页面的引用「例如一个继承了 UIViewController 的 OneVC 类，我们以 let vc = OneVC() 来取得这个页面的实例」，然后使用下面介绍的后两种页面跳转方式来跳转到这个页面。但是通过实例化取得的页面会完全与 storyboard 脱钩，这也意味着这个页面上的所有元素都必须是以纯代码创建的形式才可以显示在视图上**

iOS 中的页面切换有三种方式。

- segue
- Present
- Push

第一种是通过在 storyboard 中添加 segue 来显性关联视图的跳转；第二种是通过 present 函数来让一个 UIViewController 呈现在窗口中；第三种是通过 Push 「类似于导航栈的效果」把页面推入到路由栈内。用 segue 来控制路由的方式最为直观，所有的跳转都是显式的，修改跳转模式「mode」可以实现后两种页面跳转的效果。而后两种页面切换效果只是单纯通过编程的方式来跳转页面，形式上有所不同，本质和 segue 是一致的。


````swift
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let controller = storyboard.instantiateViewController(withIdentifier: "LoginVC")

// 对于通过实例化 storyboard 来取得的 viewController 来说，在传递参数的时候我们依然需要实例化相应的 ViewController 来传递参数
let VCwidthData = LoginVC()
VCwidthData.data =  "pass data"
// present
self.present(controller, animated: true, completion: nil)

// Push 
if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as? JunctionDetailsVC {
    if let navigator = navigationController {
        navigator.pushViewController(viewController, animated: true)
    }
}
````

都是通过取得相关的 ViewController 实例调用全局函数来完成跳转。

你在 storyboard 中建立的所有的 ViewController 在层级上都是扁平一致的，不存在什么上下级关系，任何两个页面之间都是可以互相跳转的。

##### 页面间参数传递

例如我们现在有两个页面 A 和 B，点击 A 页面中的一个按钮跳转到 B 页面，一般来说，我们需要获取到 B 页面的引用然后把 B 页面中设置好的属性进行赋值，当 B 页面被打开时参数就被传递过来了。总的来说页面间参数传递的是通过页面属性赋值来完成的。

相反的如果我们想要从 B 跳回到 A 页面，也需要同样的操作。但是由于 A 页面已经被实例化过了，此时的跳回已经无法再次解析到 A 页面的属性！除非是重新实例化「类似 Web 中一个类的构造器只会初始化一次」。但是我们可以通过在 A 中设置一个钩子函数供 B 调用，这样也可以获取到从 B 中传递回来到参数「当然你可以在任何页面中调用这个钩子函数」。



````swift
// A.swift
// 跳转到 B 页面

func goB(){
    let BVC = B()
    BVC.passData = "一些参数"
    self.present(BVC, animated: true, completion: nil)
}


// 参数钩子函数
func getData(data: String){
    print("参数是 \(data)")
}


// B.swift

var passData:String = "默认参数"

var Label = UILabel(frame: cgRect( x: 0, y: 0, width: 200, height: 20))
UILabel.text = passData


// 带参数返回 A 页面
func backA(){
    dismiss(animated: true, completion: nil)
    let AVC = A()
    AVC.getData(data: "一些参数") 
}



````

首先推荐查阅这篇文章 [在 ViewController 间传递参数](https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/)





虽然这些钩子函数可以让 ViewController 之间传递信息，但着增加了 ViewController 之间的耦合，如果有多个钩子函数事情会乱成一团。 iOS 中的这些钩子函数是页面间信息传递的桥梁，所以 iOS 把他们单独提取出来定义成了一种“协议”「protocol」，即如果页面之间共同遵守的一个协议他们必须去实现这个协议的具体内容，传递那些参数，怎么传递就变得明确多了。

protocol 可以理解为可重复利用的桥梁，一个搭在 ViewController 间的桥梁，桥梁的两边做好“约定”即可实现交流。可以理解为把我们前面用的钩子函数提升成了一个组件，组件最大的用处就是可重复利用。

在任何地方新建一个 protocol，假设我们需要通过 protocol 实现 B -> A 的信息流，那么我们有如下几个步骤需要完成：

1. 定义一个 protocol
1. 在 A 内继承并实现 protocol 协议
1. 在 B 内调用 protocol 的传参函数
1. 为了在 B 内调用 protocol 的传参函数，我们需要获取到 A 的引用并赋值给一个协议类型的变量。**赋值这步可以在 A 内完成也可以在 B 内完成**。




可以看到获取参数的 A 需要遵守协议，设定协议的发出人进而完成交流。而对协议进行调用的 B 需要取得协议的实例，这个实例拥有调用协议的能力。这样就完成了 AB 间的交流。

我们可以明显地感觉到通过协议来比通过属性传递信息麻烦复杂的多，但是 AB 间的关系解藕了，结构也更清晰了。


````swift
// A.swift
// 跳转到 B 页面

class A : UIViewController, DataDelegate {
    
    // 执行 DataDelegate 协议
    func passData(data: String){
        print(data)
    }
    
    func goB(){
        let BVC = B()
        
        // 因为我们要在 B 中使用了一个变量来保存  DataDelegate 来传递信息
        // B 指派协议，A 来遵守协议。所以 A 接受了 B 的委托
        
        BVC.delegate = self
        
        // 回掉传参
        BVC.backData = {(data: String) in
            print(data)
        }
        self.present(BVC, animated: true, completion: nil)
    }


    // 参数钩子函数
    func getData(data: String){
        print("参数是 \(data)")
    }

}


// B.swift


protocol DataDelegate{
    func passData(data: String)
}

class B : UIViewController{
    
    // 获取到 protocol 类
    var delegate:DataDelegate? = nil
    
    // 也可以获取到 A 实例，直接赋值给一个变量。如果在这里获取 A 实例，那么在 A 实例中就可以不用指定 B 的 delegate 属性为 self 了
    //var delegate:DataDelegate? = A()
    
    
    var Label = UILabel(frame: cgRect( x: 0, y: 0, width: 200, height: 20))
    UILabel.text = passData


    var backData:((String) -> Void)?
    
    // 带参数返回 A 页面
    func backA(){
        dismiss(animated: true, completion: nil)
        let AVC = A()
        
        // 调用 DataDelegate 的函数来传递参数
        delegate.passData(data: "用协议通道传递的参数")
        AVC.getData(data: "一些参数") 
        
        
        // 回掉传参
        self.backData!("回掉参数")
    }

}

````

