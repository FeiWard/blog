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
- out-of-Plane Rotation
- scale variation

# common modules
- target representation scheme
- search mechanism
- model update
- context information

# evaluation
- Precision Plot. Center location error
- Success Plot. Bounding box overlap

# papers

### SOT

- [Online Object Tracking A Benchmark](faculty.ucmerced.edu/mhyang/papers/cvpr13_benchmark.pdf)
- [Object Tracking Benchmark](http://faculty.ucmerced.edu/mhyang/papers/pami15_tracking_benchmark.pdf)
- [CT](www4.comp.polyu.edu.hk/~cslzhang/CT/eccv_ct_camera.pdf) ([project](http://www4.comp.polyu.edu.hk/~cslzhang/CT/CT.htm))
- [OAB](http://www.vision.ee.ethz.ch/boostingTrackers/Grabner2006RealTimeTracking.pdf) ([project](http://www.vision.ee.ethz.ch/boostingTrackers/onlineBoosting.htm))
- [STRUCK](http://ieeexplore.ieee.org/document/7360205/) ([CPU code in C++](https://github.com/samhare/struck), [GPU code](https://bitbucket.org/sgolodetz/thunderstruck/src))
- [TLD](ieeexplore.ieee.org/document/5540231)
- [CSK](http://www.robots.ox.ac.uk/~joao/publications/henriques_eccv2012.pdf) ([project](http://www.robots.ox.ac.uk/~joao/circulant/v))
- [KCF](http://www.robots.ox.ac.uk/~joao/publications/henriques_tpami2015.pdf) ([project](http://www.robots.ox.ac.uk/~joao/circulant/v))

### MOT

- [Learning to Track: Online Multi-Object Tracking by Decision Making](http://cvgl.stanford.edu/papers/xiang_iccv15.pdf) ([code](https://github.com/yuxng/MDP_Tracking))
- [Near-Online Multi-target Tracking with Aggregated Local Flow Descriptor](https://arxiv.org/abs/1504.02340)
- [Online Multi-Target Tracking Using Recurrent Neural Networks](https://arxiv.org/abs/1604.03635) ([code](https://bitbucket.org/amilan/rnntracking))
- [Multi-Target Tracking by Discrete-Continuous Energy Minimization](http://www.milanton.de/files/pami2016/pami2016-anton.pdf)
- [Tracking The Untrackable: Learning To Track Multiple Cues with Long-Term Dependencies](https://arxiv.org/abs/1701.01909)
- [Tracking the Trackers: An Analysis of the State of the Art in Multiple Object Tracking](https://arxiv.org/abs/1704.02781)
- [High-Speed Tracking-by-Detection Without Using Image Information](http://elvera.nue.tu-berlin.de/files/1517Bochinski2017.pdf) ([code](https://github.com/bochinski/iou-tracker/))
- [A Novel Multi-Detector Fusion Framework for Multi-Object Tracking](https://arxiv.org/abs/1705.08314)
- [Deep Network Flow for Multi-Object Tracking](https://arxiv.org/abs/1706.08482)
- [Recurrent Filter Learning for Visual Tracking](https://arxiv.org/abs/1708.03874)
- [Recurrent Autoregressive Networks for Online Multi-Object Tracking](https://arxiv.org/pdf/1711.02741.pdf)

# sources

- [Deep-Learning-for-Tracking-and-Detection](https://github.com/abhineet123/Deep-Learning-for-Tracking-and-Detection)