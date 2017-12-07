+++
title = 'Siamese Notes'
date = 2017-12-07T14:24:40+08:00
draft = true
meta_img = "/images/image.jpg"
tags = ["siamese network", "triplet loss", "metric learning"]
description = "siamese network"
+++

# task
通过样本相似度驱动权重共享的网络学习嵌入的隐变量表达(embedding vector representation)

# siamese network
#### [Learning a Similarity Metric Discriminatively, with Application to Face Verofocation](yann.lecun.com/exdb/publis/pdf/chopra-05.pdf)

假设对于正对 $(X_1, X_2)$和负对$(X_1, X_2^{\prime})$

$$\exists m>0, E_W(X_1, X_2)+m<E_W(X-1,X_2^\prime).$$

![siamese](https://user-images.githubusercontent.com/7688886/33700977-562d272a-db57-11e7-8719-a4fe230f88a9.png)

损失函数

$$ L(W)=\sum_{i=1}^{P}\ell(W,(Y,X_1,X_2)^{i}) $$
$$ \ell(W,(Y,X_1,X_2)^{i} = (1-Y)\ell_G(E_W(X_1,X_2)^i) + Y\ell_I(E_W(X_1,X_2)^i) $$

#### [Dimensionality Reduction by Learning an Invariant Mapping](https://cs.nyu.edu/~sumit/research/assets/cvpr06.pdf)

对比损失函数(contrastive loss function)

$$ \ell(W,Y,X_1,X_2) = (1-Y){1\over2}(D_W)^2 + (Y){1\over2}{max(0,m-D_W)}^2 $$

![contrastive loss](https://user-images.githubusercontent.com/7688886/33701469-d12158be-db59-11e7-8be8-bb51b597d700.png)

![contrastive loss2](https://user-images.githubusercontent.com/7688886/33701553-3c712c0c-db5a-11e7-945d-64d2ee524e61.png)

# triplet loss
#### [Learning fine-grained image similarity with deep ranking](https://arxiv.org/abs/1404.4661)


#### [deep metreic learning using triplet network](https://arxiv.org/abs/1412.6622)


假设: 对于选择的粗略相似度度量$r$, 我们希望学习到相似度函数表达 $S$

$$S(x,x_1)>S(x,x_2), \forall x,x_1,x_2 \in P \, for \, which \, r(x,x_1) > r(x,x_2)$$

网络结构

![triplet](https://user-images.githubusercontent.com/7688886/33702598-4ee7f686-db5f-11e7-8099-101a2c5c110d.jpg)

损失函数

<div>

$$ Loss(d_+,d_-)=||(d_+,d_--1)||_2^2 =const \cdot d_+^2 $$

$$ d_+ = { e^{||Net(x)-Net(x^+)||_2} \over e^{||Net(x)-Net(x^+)||_2}+e^{||Net(x)-Net(x_-)||_2} } $$

$$ d_- = { e^{||Net(x)-Net(x^-)||_2} \over e^{||Net(x)-Net(x^+)||_2}+e^{||Net(x)-Net(x_-)||_2} } $$

</div>

#### [FaceNet: A Unified Embedding for Face Recognition and Clustering](https://arxiv.org/abs/1503.03832)

假设

$$ ||f(x_i^a)-f(x_i^p)||_2^2 + \alpha < ||f(x_i^a)-f(x_i^n)||_2^2 $$

模型方面，在deep model之后加了$L2$正则，使得embedding feature都被映射到一个超球面上。

![](https://user-images.githubusercontent.com/7688886/33644926-ff46bfa4-da82-11e7-8cc8-94b3adc62a8d.png)

损失函数

$$ \sum_i^n[||f(x_i^a)-f(x_i^p)||_2^2 - ||f(x_i^a)-f(x_i^n)||_2^2 + \alpha] $$

在整个数据集上计算$argmax$和$argmin$是不太可取的，原因有二：

- 计算量太大
- 错误标记的样本和被污染的样本可能会主导难例(hard positives and negatives)

因此需要寻找hard triplets，即寻找正对(positive pairs)中距离最远的样本(hard positive)和负对(negative pairs)中距离最近的样本(hard negative)

$$ argmax_{x_i^p}||f(x_i^a)-f(x_i^p)||_2^2 $$

$$ argmin_{x_i^n}||f(x_i^a)-f(x_i^n)||_2^2. $$

很明显，正对的数量远小于负对。因此采用的策略是选择所有的positive paris，选择部分hard negatives。实际中发现，若真的选择严格的hard negatives，模型可能会坍塌($f(x)=0$)陷入局部最优。为了避免这个问题，退而求其次，选择semi-hard negatives

$$||f(x_i^a)-f(x_i^p)||_2^2 < ||f(x_i^a)-f(x_i^n)||_2^2.$$

#### [Learning Local Image Descriptors with Deep Siamese and Triplet Convolutional Networks by Minimising Global Loss Functions](https://arxiv.org/abs/1512.09272)


# 附录
[A Comparison of Loss Function on Deep Embedding](https://www.slideshare.net/CenkBircanolu/a-comparison-of-loss-function-on-deep-embedding)


