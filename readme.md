# Evaluation Tools


This repository provides usually used trajectory evaluation methods for visual-based navigation systems.

1. Commonly used error metrics: Absolute Trajectory Error (ATE) and Relative Pose Error (RPE)
2. SE3 and Sim3 trajectory alignment methods 
3. Gound-truth files from popular datasets (Kitti, EuRoC MAV, TUM_IMU, TUM_mono)

More details about ATE and RPE can be found in this [paper](https://ieeexplore.ieee.org/abstract/document/6385773/).

## Requirements

### Python 

```shell
sudo apt-get install python-argparse
```

### Matlab

Get MATLAB in <https://www.mathworks.com/products/matlab.html>

## Usage

### File Format

#### For estimating ATE and RPE

The file format of the ground-truth and estimated poses are specified.

- Each line in the text file contains a single pose.
- The format of each line is 'timestamp tx ty tz qx qy qz qw'
- tx ty tz (3 floats) give the position of the optical center of the standard camera with respect to the same world origin, e.g., the first pose.
- qx qy qz qw (4 floats) provide the orientation of the optical center of the standard camera in the form of a unit quaternion with respect to the same world origin, e.g., the first pose.

#### For Kitti

The file format of the ground-truth and estimated poses are specified.

- Each line in the text file contains a single pose.
- The format of each line is 'timestamp R11 R12 R13 t1 R21 R22 R23 t2 R31 R32 R33 t3'
- t1 t2 t3 (3 floats) give the position of the optical center of the standard camera with respect to the same world origin, e.g., the first pose.
- R11 R12 R13 R21 R22 R23 R31 R32 R33 (9 floats) provide the orientation of the optical center of the standard camera in the form of a rotation Matrix with respect to the same world origin, e.g., the first pose.

### Evaluation

#### Evaluating trajectories with metric scale

- evalute_ate.py
    - This script computes the absolute trajectory error from the ground truth trajectory and the estimated trajectory. 
- evaluate_rpe.py
    - This script computes the relative pose error from the ground truth trajectory and the estimated trajectory. 

#### Evaluating trajectories with a unkonwn scale. E.g., the results from mono VO/SLAM

- evalute_ate_scale.py
    - This script computes the absolute trajectory error from the ground truth trajectory and the estimated trajectory. 
- AlignSimEfficient: 
    - The function of this script is the same as above, aligning trajectory with a sim(3) to compute ATE RMSE.

#### Evaluaing trajectories for Kitti

[Lean More](Kitti-devkit/readme.txt)



