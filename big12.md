## 知识点串讲

### 1、java

- 集合

  - ArrayList

    数组 ， 容量，擅长读

  - LinkedList

    通过引用实现，Node , 两头找。fistNode，lastNode，擅长写。

  - HashMap

    哈希原理，散列，分桶机制（默认分16桶，扩容）。

    哈希原理，最好是O(1) ， 最差O（n）。

    ```java
    (oldhash >>> 16 ^ oldhash) & buckets => 0 - 15
    ```

  - 时间复杂度

    冒泡排序 : $$ 最坏是 O(N^2) ， 最好O(n)$$

    折半查找 : $$ O (log_2{n}) $$

- 多线程

  - 常用方法

    yield()

    join()

    sleep()			//休眠,跟锁无关

    wait(int n )		//等待，将当前线程放到锁旗标的等待队列中。notify()/notifyAll()/timeout

    start()			//启动线程

    run()			//业务代码

  - 安全控制

    synchronized ,同步方法和同步代码块。同步方法粒度粗，代码块细。增强安全性，丧失并发度。

    violatile , 脆弱的。属性值立即可见，变量被其他线程修改后，立即可见。

    上锁机制 ： 静态方法使用当前的class描述符作为锁，如果非静态方法以自身对象作为锁。同步代码块指定锁对象。

  - 线程状态

    - NEW
    - Runnable
    - Blocked
    - Waiting
    - Timed_waiting
    - Terminated

  - 线程问题的变化过程

    synchronized -> 解决安全问题 ，产生了生产消费问题 -> wait | notify()-> 解决了生产消费问题，导出死锁问题--> notifyAll()|wait(n) ;

- NIO

  - New IO，非阻塞。

    挑选器模型，Selector，ServerSocketChannel,SocketChannel , SelectionKeys.ACCEPT| SelectionKeys.READ| SelectionKeys.WRITE| SelectionKeys.CONNECT

    selector维护了三个集合，keys | selecttionKeys | cancelledKeys

  - 零拷贝

    FileChannel.transferTo() , 不能超过2G，kafka，Spark，nginx（linux sendFile）

    disk -> 系统空间(内核空间) -> 用户空间 -> 用户空间 -> 系统空间 -> 输出Buffer

    disk -> 系统空间 -> 输出Buffer

  - 虚拟内存

    通过FileChannel将文件特定区域映射到内存，实现对文件的高速IO。

  - Buffer

    postion 	:指针

    mark	:记号

    limit	:限制

    capacity:容量

    flip() | read() | write() | clear

- JVM

  runtime data area ,运行时数据区。

  - method area

    存放类和静态成员，永久区，共享的。

  - heap

    存放对象和数组，共享。

  - java stack

    线程 ，压入的是 method frame(stack frame),pop() | push

  - native method stack

  - program counter register

  - 从堆角度划分JVM结构

    - heap

      - 年轻代
        - 伊甸区
        - 幸存区
          - 幸存一区
          - 幸存二区

      - 年老代

    - non-heap

      非堆，JVM - heap

    - off-heap

      离堆空间，OS - JVM，ByteBuffer.allocateDirectBuffer(1024) ;

  - 常用JVM工具

    jconsole

    jvisualvm

    jmap

    jstat

    jstack

  - GC

    garbage collect,垃圾回收。

    minor GC	:

    full GC		:

- 设计模式

  - 单例模式

    懒汉			//线程安全问题

    饿汉

  - 工厂

    静态非静态

  - 装饰

    IO , 

  - builder

    构建器模式，方法链编程，SparkSession , Interceptor

  - adaptor

    适配器，预实现。抽象类。

  - 责任链模式

    链条方式先后传递。

  - 观察者模式

     Observer,Observable.

  - 代理

    不改变类的源代码，还为类增加新功能。

    Proxy,Spring AOP编程，jdk的proxy也叫做JDK的动态代理，也称为接口代理。

  - 池化

    容器概念，连接池。池化的对象是共享的，因此是无状态(状态是值针对每个不同的客户端有不同的属性值进行保持)的。

- 数据结构

  - 队列

    FIFO

  - 栈

    FILO

  - 二叉树

    red-black树。旋转调整。

- 并发库

  - java.util.concurrent

    Executors

    ExecutorService

    FixedThreadPool		//固定线程池。

  - Executor.newFixedThreadPool(core,max,...)

    固定线程池内部使用原子量的控制信号来实现。

    AtomicInteger ，ai.getAndIncrement() , ai.incrementAndGet() , ai.geAndSet() ai.setAndGet();

    CAS : compared and sweep，比较再交换值。

      状态              worker数

    ---3---|-----------  29 -------------

    RUNNING		//营业中

    SHUTDOWN		//打烊，处理现有任务，不再接受新任务

    STOP			//整改，立即停止所有事务，不能接受新任务

    TIDYING			//TERMINATED前奏，所有任务已完成，worker数归0，线程进入该状态，将调用terminate()方法.

    TERMINATED	//terminated()结束后。

  - 轻量级锁，

    ReentrantLock,ReentrantReadWriteLock，

    read() | write()

  - 线程池执行任务

    异步执行，任务进入队列，有worker调用。

    execute()		//无返回值，异步调用。

    submit()		//有返回值，返回Future对象，可以实现同步执行。

- socket

  - 七层协议

  - 传输层

    TCP 			//有链接，有顺序，安全，三次握手(2次身份识别 , syn | ack)

    UDP			//无连接，无固定路由，无回执，不安全，有限制（64K），无顺序

  - 网络层

    IP				//

  - 

- 反射和内省

  - 反射涉及的类

    动态访问类或者对象的属性和方法。

    Class | Method | Field | Constructor | 突破修饰符的控制

  - 内省

    专门用于处理javabean的工具类。

    Introspector，BeanInfo，PropertyDescriptor

- ClassLoader

  类加载器主要是将class结构映射到class文件路径，加载字节码文件。

  三级类加载机制 ： Bootstrap(加载系统类) -> ExtClassLoader(加载jre/lib/*jar) -> AppClassLoader(加载自定义类或第三方类)

- JDBC

  - 事务

    A		//atomic

    C		//consistent

    I		//isolate

    D		//durable , 

### 2、hadoop

- 分布式计算引擎。

- 模块

  - common

  - hdfs

    namenode				//存放元数据，blocksize，副本数，多目录配置（副本化）

    datanode				//启动报告，多目录配置（扩容）

    Secondary namenode	//检查点，images + edits

    Journal node			//HA，active + standby ，构成小集群

    ZKFC					//容灾控制器，

    Fedeartion				//联邦， HA + 扩容。

  - yarn

    资源调度框架。

    ResourceManager

    NodeManager			//8088

  - mapreduce

    高度抽象的编程模型。

    InputFormat -> RecordReader -> Mapper -> Partiton -> Combine -> Reduce->OutputFormat -> Writer

    M+/RM?

    MultiInputs.addInputFormat( ...)

    - map

      映射，分区(reduce个数) -> Combine(非空的分区数) ， 缓冲区（默认100m ， 阈值80%）溢出到磁盘 ，

      个数由InputFormat决定。 默认的格式是TextInputFormat，计算切片（）

    - reduce

      化简，在reduce侧进行shuffle处理。

      copy -> merge -> sort -> 分组 -> 聚合。

    - Shuffle

      混洗， 在map和reduce进行数据传输。

    - MR

      切片算法：中值计算(maxSplit minSplit blockSize)。

      切片数量 :  10%尾值计算。

  - 排序

    - 部分排序

      按照key

    - 全排序

      所有key的进行排序

      一个reduce

      自定义分区 + reduce

      采样

    - 二次排序

      自定义key

      自定义分区

      自定义排序对比器

      自定义分组分组对比器

  - write剖析

    pipeline

    Block (128M), DFSPacket(64K) , chunk(512字节) 。 

  - 连接

    - map端连接

      小表 + 大表 , 没有shuffle。小表数据载入内存。

    - reduce端连接

      大表 + 大表

  - 数据倾斜

    - 重新设计key
    - 自定义分区

- 集群模式

  - 本地模式

    单个JVM多线程模拟。

  - 伪分布

  - 完全分布

  - HA

  - Federation

### 3、hive

数据仓库，构建在hadoop之上。sql方式，转换成mr，OLAP。RDBMS(OLTP)。

元数据在rdbms，数据在hdfs上。

Oracle也是可以做数仓。

- 数据库

  hdfs目录

- 表

  hdfs目录

  内部表		//托管表

  外部表		//不删数据

  分区表		//分区也是对应目录

  桶表		//对应文件

- 函数

  - 高级聚合函数

    grouping sets | cube |rollup

  - 分析函数

    rank			//rows between .. and ..

    dense_rank		//range between .. and ..

    row_num

    first_value

    last_value

  - udf

    普通函数

  - udtf

    表生成函数

  - udaf

    聚合函数

- 优化

  - 分区表

  - 本地化(local)

  - map端连接

  - 数据倾斜

    skewJoin配置参数，二次job。

  - 大量文件

    配置mapper个数。

  - 文件格式

    parquet，列存储。发挥磁盘线性读写。和投影查询结合(投影查询是检索若干字段，不是全部字段)。

  - 启用压缩

    中间输出结果可以启用压缩，降低网络和磁盘的压力，cpu压力变大。

  - 全排序

    distribute by + sort by ,不要用order by使用一个reduce.

- hive建模

  从hive表的逻辑关系上进行划分，表从业务角度划分为维度表(字典表)和事实表。

  - 星型

    维度表多张，事实表一张，维度表无关联。查询性能好，存储有冗余，使用较多。

  - 雪花型

    是星型的扩展，维度表之间有关系，存储冗余少，一张事实表。

  - 星座型

    也是星型的扩展，存在多张事实表。

- hive数仓分层

  - ODS

    Operate data store，操作数存储。

  - DW

    data warehouse，数据仓库层。

  - DM

    data market ，数据集市。

- 拉链表

  hive支持有条件的update和删除。

### 4、hbase

三级坐标，rowkey/family:col/timestamp = value

- NoSQL

  Not only SQL，随机定位和实时读写。bigTable，十亿行\*百万列 \*上千版本

- 进程

  hmaster			//管理节点

  hregionserver		//区域服务器

  需要zookeeper。

- 术语

  - namespace

    目录 , 

  - table

    目录

  - column family

    目录

  - quarlifier

  - regionname

     区域，目录。

- rowkey

  加盐，宏观分散，微观连续。

  scan ： 

- 优化措施

  - 防止切割风暴

    默认10g进行切割。

  - rowkey

    hash加盐， 分区数取偏移量。

  - 读优化

    - scan 设置起始和结束行

    - 应用filter

    - cache

    - batch

    - 二级索引

      phoenix的索引机制就是二级索引的典型应用。

  - 写优化

    - 关闭hbase客户端buffer默认自动清理
    - 关闭WAL
    - 表的预切割
    - 启用多线程写入

- observer

  - RegionObserver

    类似于触发器。

### 5、flume

日志收集工具。

agent组件：

- source

  输入 , 

  - ExecSource

    防重复、防丢失，借助于redis。

  - SpoolDirSource

  - Netcat

  - AvroSource

- channel

  缓存 , 通道，

  - MemoryChannel

    快，丢失数据，内存溢出，SpeedInterceptor。

  - FileChannel

    慢，可靠。

- sink

  输出

### 6、kafka

message midleware，消息中间件。独立|剥离出来。

传统的消息中间件消息模型：p2p(Point 2 Point和pubsub(publish subscribe，发布订阅)

消息系统，ha，分布式，副本，+zookeeper。

broker , 分区leader，主题概念。

destination ： 目的地，queue(p2p) |topic(pubsub)

consumerGroup : 同一组内，只有一个消费者消费主题的消息。

消息存活周期是168hour。主题有副本和分区数。

分区数设置为cpu的核数比较合适。每个分区的容灾能力$$n  - 1$$

- 生产者

  buffer , kafka消息是异步发送的，linger.timeout逗留时间。

  kafka消息是kv对。指定kv的反串行化器类。

  发送消息可以指定分区，消息直接进入特定分区。

  不指定分区，使用key轮询机制发送到每个分区。

  分区内的消息是强顺序的，即先发先到。偏移量是连续的数字。

  - ack

    0	//不确认

    -1	//都确认

    1	//leader落盘就回执

- 消费者

  指定主题，指定分区，消费者组

  - offset.reset

    偏移量自动重置，latest | earliest

  - offset.autocommit

    消费者拿到数据，是否自动提交偏移量。

- 偏移量

- 消费语义模型

  关闭偏移量的自动提交

  - atmost once

    最多消费一次

    commit();

    consume()

  - atleast once

    最少消费一次

    ```java
    //先消费
    consume()
    //后提交
    commit();
    ```

    extract once

    精准一次

    ```java
    tx = ... ;
    tx.begin();
    try{
      consume();
      updateOffsetInDB() ;
    }
    tx.commit();
    tx.rollback();
    ```

### 7、scala

- 高阶函数

  -  匿名函数

    ```scala
    val f : (a:Int,b:Int)=>a +  b
    ```

- 柯里化

  ```scala
  //更好应用隐式转换和隐式值
  f(..)(implicit ..)
  ```

- 尾递归

  避免stackoverflow。

- 泛型

  - 上界

    ```scala
    <:
    ```

  - 下界

    ```scala
    >:
    ```

  - 视图界定

    能够隐式转换成所需要的类型.

    ```scala
    T <% Comparable[T]
    ```

- 隐式转换

- 模式匹配

  ```scala
  c match{
  	case '+' => ...
      case _   => ...
  }
  ```

- 偏函数

  ```scala
  val f:PartialFunction[A,B] = {
    
  }
  ```

### 8、Spark

- 集群模式
  - local
  - standalone
  - yarn
  - mesos

- job部署模式
  - client
  - cluster

- Broadcast

  是BT(bit torrent)原理，我为人人，人人为我。减少网络数据传输量，是通过scala的lazy实现。

- job提交

  两步过程。driver端提交job使用三级调度框架，DagSch -> TaskSch - BackendSch

  - 资源分配

    master -> worker - > executor

  - 提交job

    driver -> launchTask -> 线程 -> 

- DAGSch

  计算stage，Shuffle边界计算。

- TaskSch

- BackendSch

- RDD依赖

  - 窄依赖

    子RDD的每个分区依赖于少量的父RDD分区

  - 宽依赖

    ShuffleDep

- Stage

  阶段可以跨越多个rdd。

  SuffleMapStage

  ResultStage

- RDD

  弹性分布式数据集，内置5属性

  - 分区列表
  - 依赖列表
  - 计算函数
  - 首选位置
  - 分区类

- Task

  一个阶段包含多个任务。

  ShuffleMapTask

  ResultTask

- Dependency

- 资源划分

  --executor-cores

  --total-executor-cores

  --num-executors

  --executor-memory

  --task.cores=1

- 优化

  - 算子优化

    - reduceByKey/groupByKey()/aggregateBykey()()
    - coarslce(n , shuffle=false)/repartition
    - foreachPartition

  - 资源优化

    --调参

  - shuffle优化

    - ByPass

      传统方式，不缓存，直接进磁盘，最后合并一个文件。分区数 < 200 ,没有map端聚合，内存消耗少。

    - Serialize

      串行化方式，串行化器支持二进制数据的重新定位，map端没有聚合器，分区数 < 16M，引入缓存区，分区id和key组合形成。

    - Sort

      排序方式，进行预聚合，使用Map<<ParId,Key>,value>。

  - jvm

  - RDD优化

    cache/persist()

  - 广播变量

    减少driver的压力，减少网络负载。

  - spark streaming产生大量小文件

    不用saveRDD方法，通过forEachRDD(forEachPartition(..))

  - 数据类型

    尽量使用基本类型和数组。

  - spark sql

    避免复杂sql，多次嵌套，启用临时表。

    DataFrame.cache();


### 9、python

- 列表

  ```py
  x = []
  ```

- 元组

  ```python
  x = (1,2,3)
  ```

- 字典

  ```python
  x = {100:"" , 2000:""}
  ```

- Set

  ```python
  s = Set(x)
  ```

- for

  ```python
  for x in list:
      ... 
  ```

- 协同过滤算法

  - 相似度

    - jaccard

    - cos

    - johnbreese

      惩罚了流行度。

  - userCF

    基于用户的协同过滤，找到K个和用户u相似的用户，再从K个用户中找出交互的商品，过滤掉用户u已经交互的商品。计算剩余的偏好值。用户u对每件商品的偏好值就是相似的用户中凡是跟商品交互了的用户与用户u的相似度累加和。

  - itemCF

    商品协同过滤，根据用户u以往的购买记录进行推荐。

    找出和以往商品相似的K个商品，过往购买的商品与商品的相似度累加和。

### 10、redis

NoSQL，内存数据库，通常用户缓存。11000/s  ， 8000/s。

key-value存储

- 类型
  - hash
  - list
  - set
  - sorted set(zset)
- 事务管理
  - multi
  - exec
  - discard

### 11、linux

- sed 

  流是文件编辑器

- awk

  字处理

- tar

- uname

- yum

- nc

- nano | vim

- grep | ps | netstat

### 12、zookeeper

分布式协同软件。放SPOF（single point of failure）

- 节点类

  永久节点，persist

  临时节点，transient

  序列节点，sequential

- 进程

  - leader
  - follow

- 快速选举法

  zx越大越优先，sid越大越优先。

- 观察者

  one consume，实现重复观察。

- 分布式锁

  临时节点序列节点，0000000x

- 容灾能力
  $$
  \frac{n-1}{2}
  $$








### 13、爬虫

httpclient类实现，xpath，css

- 应对反爬

  - 代理主机

  - userAgent

  - 账号

  - 限速

  - 登录退出

  - cookie

  - selinum + chrome.driver

    完全模拟浏览器程序。

- 分布式爬虫

  调度task从redis中取url地址，失败重试次数。

### 14、userProfile

分词，结巴分词，NLPIR分词，viterbi分词

关键词抽取 ： textrank() ,tfidf

分类 ：naivebayes分类。

- 实时
  $$
  \frac{\frac{click + 1}{expose + \frac{1}{均值}} - 均值}{均值}
  $$

- 离线

  k-v : <userid_day, [a1,a2,a3]>

  <userid,C1_click_export_weight,C2_xxxx>


