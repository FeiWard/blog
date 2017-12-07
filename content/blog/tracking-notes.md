+++
title = 'Tracking Notes'
date = 2017-12-07T13:53:47+08:00
draft = true
meta_img = "/images/image.jpg"
tags = ["tracking"]
description = "tracking overview"

+++

# task
Given the initialized state (e.g., position and size) of a target object in a frame of a video, the goal
of tracking is to estimate the states of the target in the subsequent frames.

# difficulties
- illumination variation
- occlusion
- background clutters
- fast motion
- Out-of-Plane Rotation
- scale variation

# common modules
- target representation scheme
- search mechanism
- model update
- context information

# evaluation
- Precision Plot. Center location error.
- Success Plot. Bounding box overlap.

# papers
- CVPR2013 Online Object Tracking A Benchmark
- [Object Tracking Benchmark](http://faculty.ucmerced.edu/mhyang/papers/pami15_tracking_benchmark.pdf)
- [CT]()
- [OAB]()

- [STRUCK](http://ieeexplore.ieee.org/document/7360205/)
    * [CPU code in C++](https://github.com/samhare/struck)
    * [GPU code](https://bitbucket.org/sgolodetz/thunderstruck/src)
- [TLD]()
- [CSK](http://www.robots.ox.ac.uk/~joao/publications/henriques_eccv2012.pdf)
    * [project](http://www.robots.ox.ac.uk/~joao/circulant/v)
- [KCF](http://www.robots.ox.ac.uk/~joao/publications/henriques_tpami2015.pdf)
    * [project](http://www.robots.ox.ac.uk/~joao/circulant/v)