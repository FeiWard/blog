---
title: caffe轻度使用体验
date: 2016-05-05 21:39:28
categories: 科研
tags:
  - caffe
  - cuda
  - anaconda
---
# 简单说明
caffe毫无疑问是现在使用比较广泛的深度学习网络框架，每一个学习卷积神经网络的人，应该都不可避免要体验一下caffe的特性和魔力。

由于第一次在装cuda时，不小心将ubuntu装死，导致在登陆界面无法登陆，输入正确密码后闪一两秒钟然后又回到登陆界面。用谷歌搜索各种解决方法均无效后，索性重装系统，然后记录每一步。

<!--more-->

# 安装步骤
- MATLAB

  MATLAB的安装按照官方说明即可，一般没有什么坑。需要注意的是，MATLAB的版本与cuda的版本有一个对应关系，在caffe官网有详细说明，在此不表。

- Python

  推荐使用anaconda。安装完毕之后，如果无法忍受conda下载速度慢，可以添加[清华源](https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/)。

  ```
conda config --add channels 'https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/'
conda config --set show_channel_urls yes
  ```

- cuda

  之前装cuda将系统装死，很有可能是因为一些依赖库没有装好。因此在装cuda之前，最好将[caffe ubuntu installation](http://caffe.berkeleyvision.org/install_apt.html)中说明的依赖库
  ```
  sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler

  sudo apt-get install --no-install-recommends libboost-all-dev
  ```
  全都确认安装成功后，再更新系统内核以及软件包
  ```
  sudo apt-get update && sudo apt-get upgrade -y

  ```
  最后再安装cuda
  ```
  sudo dpkg -i cuda*.deb

  sudo apt-get update && sudo apt-get dist-upgrade

  sudo apt-get install cuda
  ```
  重启系统后，确认英伟达驱动是否已正确安装。
  这时，还需要将cuda添加到系统路径，修改路径`～/.bashrc`，请根据个人软件路径以及软件版本相应添加以下内容

  ```
  export PATH=/usr/local/cuda-7.5/bin:$PATH

  export LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64:$LD_LIBRARY_PATH
  ```
  然后`source ~/.bashrc`使得修改结果生效，输入`nvcc -V`确认路径添加正确，此时cuda安装完毕。

- caffe
  首先进入python文件夹，将Python依赖包全部安装
  `for req in $(cat requirements.txt); do pip install $req; done`
  然后在caffe根目录
  `cp Makefile.config.example Makefile.config`
  打开Makefile.config后，添加MATLAB和Python的路径（如果装了anaconda那就是配置anaconda的路径）。
  然后就可以编译测试了

  ```
make all
make test
make runtest
  ```
  
  没有错误的话，就可以进行Python接口和MATLAB接口的编译了。
  ```
  make pycaffe
  make matcaffe
  ```

至此caffe安装结束。

# caffe使用
caffe官方的mnist,imagenet等几个例子都写得非常详细，按照文档一步一步来，跑几个demo都是比较简单的。跑完demo后，如何用自己的数据来训练网络呢？

参考imagenet的实例以及[train-and-test-lenet-on-your-dataset](http://sites.duke.edu/rachelmemo/2015/04/03/train-and-test-lenet-on-your-own-dataset/)后，摸清楚了如何训练自己的数据了。

首先将原始数据准备好，比如我的路径是`～/Documents/datasets/mw`，该目录下有两个文件夹`pos`和`neg`分别存放正负样本图片。caffe的实例中，训练数据都是放在`caffe/data`中，因此需要将图片分为test,val以及test（或者简单点只需要分为train和test即可）同时需要在该目录下生成一个train.txt，val.txt以及test.txt（简单相应只需要train.txt和test.txt），txt文件内容，每一行都是相应图片以及标签。因此为了方便完成这个数据预处理工作，我写了一个Python脚本
```python
# -*- coding:utf-8 -*-
import os
import shutil
import random
import math

LABEL = [1,0]
src_pathbase = '/home/camel/Documents/datasets/mw/'
PATH = [src_pathbase+cate for cate in ['pos','neg']]
# print PATH

des_pathbase = '/home/camel/Documents/caffe/data/mw/'
DPATH = [des_pathbase+cate for cate in ['train','val','test']]
# print DPATH

for txt in ['train.txt','val.txt','test.txt']:
	open(des_pathbase+txt,'w').close()
for p in DPATH:
	if os.path.exists(p):
		shutil.rmtree(p)
	os.makedirs(p)


for k in xrange(len(PATH)):
	img_files = os.listdir(PATH[k])
	img_num = len(img_files)
	train_num = int(math.ceil(img_num * 0.9))
	test_num = img_num - train_num
	val_num = int(math.ceil(train_num * 0.1))
	train_num = train_num - val_num
	test_list = sorted(random.sample(xrange(img_num),test_num))
	train_val_list = list(set(xrange(img_num))-set(test_list))
	val_list = sorted(random.sample(train_val_list,val_num))
	train_list = list(set(train_val_list)-set(val_list))
	print img_num,train_num,val_num,test_num
	print train_list,len(train_list)
	print val_list,len(val_list)
	print test_list,len(test_list)

	for n in xrange(img_num):
		fpath = os.path.join(PATH[k],img_files[n])
		print fpath
		if n in train_list:
			print "belongs to train"
			with open('/home/camel/Documents/caffe/data/mw/train.txt','a') as f:
				f.write("%s %d" % (img_files[n],LABEL[k]))
				f.write('\n')
			shutil.copy(fpath,DPATH[0])
		elif n in val_list:
			print "belongs to val"
			with open('/home/camel/Documents/caffe/data/mw/val.txt','a') as f:
				f.write("%s %d" % (img_files[n],LABEL[k]))
				f.write('\n')
			shutil.copy(fpath,DPATH[1])
		elif n in test_list:
			print "belongs to test"
			with open('/home/camel/Documents/caffe/data/mw/test.txt','a') as f:
				f.write("%s %d" % (img_files[n],LABEL[k]))
				f.write('\n')
			shutil.copy(fpath,DPATH[2])

```
数据准备好之后，将imagenet下的create_imagenet.sh拷贝到`caffe/examples/mw`下，作一些修改，我的修改如下，可根据自己的目录进行相应调整
```
EXAMPLE=examples/mw
DATA=data/mw
TRAIN_DATA_ROOT=data/mw/train/
VAL_DATA_ROOT=data/mw/val/

echo "Creating train lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    --shuffle \
    --gray \
    $TRAIN_DATA_ROOT \
    $DATA/train.txt \
    $EXAMPLE/mw_train_lmdb

echo "Creating val lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    --shuffle \
    --gray \
    $VAL_DATA_ROOT \
    $DATA/val.txt \
    $EXAMPLE/mw_val_lmdb
```
  那么运行该脚本后，就会将自己的数据生成caffe可处理的数据格式了。其他的就是将train_test.prototxt进行相应的修改，数据上主要修改source下的目录，对应刚刚生成的文件，比如我的就是`source: "examples/mw/mw_train_lmdb"`和`source: "examples/mw/mw_val_lmdb"`。

  至此，将自己的数据应用到caffe上大部分都完成了，剩下的就是根据lenet或者imagenet参考设计修改CNN结构。在此不赘述了。
