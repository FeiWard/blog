---
title: windows安装caffe并编译fast-rcnn-demo
date: 2016-09-01 20:56:28
categories: 科研
tags:
  - caffe
  - windows
  - fast-rcnn
---
# microsoft caffe
首先在微软github主页下载[microsoft-caffe](https://github.com/microsoft/caffe)，官方的编译运行文档写得比较详细，按照步骤来利用VS编译一般没什么问题。一般常见的问题是<code>error C2220: 警告被视为错误</code>，只需**右键项目，属性，C/C++，Treat Warnings as Error设置为No**即可。附上个人的[CommonSettings.props](http://7xt5lb.com2.z0.glb.clouddn.com/CommonSettings.props)，仅供参考。

所有项目编译成功之后，将<code>caffe_root\Build\x64\Release\pycaffe</code>设置环境变量PythonPath。设置之后打开Python，若import caffe成功则表示编译成功。

# caffe mnist 示例
Windows下很多人用cygwin来模拟一些Linux操作，个人推荐使用[Babun](http://babun.github.io/)，一款优雅好用的Windows shell工具。

按照caffe官网[mnist文档](http://caffe.berkeleyvision.org/gathered/examples/mnist.html)一步一步即可。

### 下载数据集

  + 进入babun
  + cd到caffe_root
  + 输入<code>./data/mnist/get_mnist.sh</code>

### 转化数据集为lmdb
  
+ 修改<code>./examples/mnist/create_mnist.sh</code>, 第8行<code>BUILD=build/examples/mnist</code> --> <code>BUILD=Build/x64/Release</code>, 第17行和第19行<code>convert_mnist_data.bin</code> --> <code>convert_mnist_data</code>
+ 同样在Babun下，输入<code>./examples/mnist/create_mnist.sh</code>

### 训练Lenet
  + 修改<code>./examples/mnist/train_lenet.sh</code>, 第4行<code>./build/tools/caffe train --solver=examples/mnist/lenet_solver.prototxt $@ -->
    ```
     BUILD=Build/x64/Release
     $BUILD/caffe train --solver=examples/mnist/lenet_solver.prototxt $@
    ```
  
  + 在babun下，输入<code>./examples/mnist/train_lenet.sh</code>，得到如下图结果，示例mnist成功跑通

  ![lenet_result](http://7xt5lb.com2.z0.glb.clouddn.com/lenet_win.jpg)

# fast rcnn demo示例
上面这些步骤完成后，如果直接进入fastrcnn-root,运行<code>python ./tools/demo.py</code>（**注意：此时在cmd中运行即可，目前babun自带Python，但是好像不能调用系统自带的python**）会提示不存在ROIPooling，导致demo运行失败。进入caffe项目发现，roi_pooling_layer.cpp 以及 roi_pooling_layer.cu根本就没有编译。因此将 roi_pooling_layer.cpp 添加进 libcaffe-src 中，将 roi_pooling_layer.cu 添加进 libcaffe-cu 中，再重新编译即可。

再次运行<code>python ./tools/demo.py</code>得到结果如下

![demo](http://7xt5lb.com2.z0.glb.clouddn.com/fastrcnn_demo.jpg)

![demo_pic](http://7xt5lb.com2.z0.glb.clouddn.com/fastrcnn_demo_pic.png)

# 后续
后续就是在fast rcnn上训练自己的数据了，Linux上已经跑通，Windows上有待测试。