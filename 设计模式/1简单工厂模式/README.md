#### 模式动机 
考虑一个简单的软件应用场景，一个软件系统可以提供多个外观不同的按钮（如圆形按钮、矩形按钮、菱形按钮等）， 这些按钮都源自同一个`基类`，不过在继承`基类`后不同的`子类`修改了部分属性从而使得它们可以呈现不同的外观，如果我们希望在使用这些按钮时，不需要知道这些具体按钮类的名字，只需要知道表示该按钮类的一个参数，并提供一个调用方便的方法，把该参数传入方法即可返回一个相应的按钮对象，此时，就可以使用`简单工厂模式`。

#### 模式定义
`简单工厂模式(Simple Factory Pattern)`：又称为静态工厂方法(Static Factory Method)模式，它属于类创建型模式。在简单工厂模式中，可以根据参数的不同返回不同类的实例。简单工厂模式专门定义一个类来负责创建其他类的实例，被创建的实例通常都具有共同的`父类`。

####模式结构

![2AE0F6379463DCA0E68ED71F3069AD0A.png](http://upload-images.jianshu.io/upload_images/117999-1c88f8354c14d1a7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###代码分析
```
+(LHBaseCalculate<LHCalculate> *)createCalcute:(NSString *)calculatetype{
    
    NSArray *calculateArray = @[@"+",@"-",@"*",@"/"];
    CalculateType calType = [calculateArray indexOfObject:calculatetype];
    
    switch (calType) {
        case calcuteTypeAdd:
            return [[LHCalculateAdd alloc]init];
            break;
        case calcuteTypeMinus:
            return [[LHCalculateMinus alloc]init];
            break;
        case calcuteTypdeMultipy:
            return [[LHCalcuteMultiply alloc]init];
            break;
        case calcuteTypeDivide:
            return [[LHCalculateDivide alloc]init];
            break;
        default:
            return nil;
            break;
    }
}
```
#### 简单工厂模式的优点 
> - 工厂类含有必要的判断逻辑，可以决定在什么时候创建哪一个产品类的实例，客户端可以免除直接创建产品对象的责任，而仅仅“消费”产品；简单工厂模式通过这种做法实现了对责任的分割，它提供了专门的工厂类用于创建对象；
- 客户端无须知道所创建的具体产品类的类名，只需要知道具体产品类所对应的参数即可，对于一些复杂的类名，通过简单工厂模式可以减少使用者的记忆量；
- 通过引入配置文件，可以在不修改任何客户端代码的情况下更换和增加新的具体产品类，在一定程度上提高了系统的灵活性。

###简单工厂模式的缺点
> - 由于工厂类集中了所有产品创建逻辑，一旦不能正常工作，整个系统都要受到影响；
- 使用简单工厂模式将会增加系统中类的个数，在一定程序上增加了系统的复杂度和理解难度；
- 系统扩展困难，一旦添加新产品就不得不修改工厂逻辑，在产品类型较多时，有可能造成工厂逻辑过于复杂，不利于系统的扩展和维护；
- 简单工厂模式由于使用了静态工厂方法，造成工厂角色无法形成基于继承的等级结构。

### 适用环境
在以下情况下可以使用简单工厂模式：
> - 工厂类负责创建的对象比较少：由于创建的对象较少，不会造成工厂方法中的业务逻辑太过复杂。
- 客户端只知道传入工厂类的参数，对于如何创建对象不关心：客户端既不需要关心创建细节，甚至连类名都不需要记住，只需要知道类型所对应的参数。

[实例](https://github.com/hua16/summary/tree/master/%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F/1%E7%AE%80%E5%8D%95%E5%B7%A5%E5%8E%82%E6%A8%A1%E5%BC%8F)