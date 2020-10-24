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

### Matlab (Optioanl)

Get MATLAB in <https://www.mathworks.com/products/matlab.html>

### C++ (gcc) for Kitti

``` shell
g++ -O3 -DNDEBUG -o evaluate_odometry evaluate_odometry.cpp matrix.cpp
```

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

#### Evaluate trajectories with metric scale

- evalute_ate.py
    - This script computes the absolute trajectory error from the ground truth trajectory and the estimated trajectory. 
    - --offset OFFSET: time offset added to the timestamps of the second file (default: 0.0)
    - --scale SCALE: scaling factor for the second trajectory (default: 1.0)
    - --max_difference MAX_DIFFERENCE: maximally allowed time difference for matching entries (default: 0.02)
    - --save: save aligned second trajectory to disk (format: stamp2 x2 y2 z2)
    - --save_associations SAVE_ASSOCIATIONS: save associated first and aligned second trajectory to disk (format: stamp1 x1 y1 z1 stamp2 x2 y2 z2)
    - --plot PLOT: plot the first and the aligned second trajectory to an image (format: png)
    - --verbose: print all evaluation data (otherwise, only the RMSE absolute translational error in meters after alignment will be printed)

    ``` shell
    usage: evaluate_ate.py [-h] [--offset OFFSET] [--scale SCALE]
                       [--max_difference MAX_DIFFERENCE] [--save SAVE]
                       [--save_associations SAVE_ASSOCIATIONS] [--plot PLOT]
                       [--verbose]
                       first_file second_file
    ```

- evaluate_rpe.py
    - This script computes the relative pose error from the ground truth trajectory and the estimated trajectory. 
    - --max_pairs MAX_PAIRS: maximum number of pose comparisons (default: 10000, set to zero to disable downsampling
    - --fixed_delta: only consider pose pairs that have a distance of delta delta_unit (e.g., for evaluating the drift per second/meter/radian)
    - --delta DELTA: delta for evaluation (default: 1.0)
    - --scale SCALE: unit of delta (options: \'s\' for seconds, \'m\' for meters, \'rad\' for radians, \'f\' for frames; default: \'s\'
    - --offset OFFSET: time offset between ground-truth and estimated trajectory (default: 0.0)
    - --scale SCALE: scaling factor for the estimated trajectory (default: 1.0)
    - --save SAVE: text file to which the evaluation will be saved (format: stamp_est0 stamp_est1 stamp_gt0 stamp_gt1 trans_error rot_error)
    - --plot PLOT: plot the result to a file (requires --fixed_delta, output format: png)
    - --verbose: print all evaluation data (otherwise, only the mean translational error measured in meters will be printed)

    ``` shell
    usage: evaluate_rpe.py [-h] [--max_pairs MAX_PAIRS] [--fixed_delta]
                       [--delta DELTA] [--delta_unit DELTA_UNIT]
                       [--offset OFFSET] [--scale SCALE] [--save SAVE]
                       [--plot PLOT] [--verbose]
                       groundtruth_file estimated_file
    ```

#### Evaluate trajectories with a unkonwn scale. E.g., the results from mono VO/SLAM

- evalute_ate_scale.py
    - This script computes the absolute trajectory error from the ground truth trajectory and the estimated trajectory. 
    - --offset OFFSET: time offset added to the timestamps of the second file (default: 0.0)
    - --max_difference MAX_DIFFERENCE: maximally allowed time difference for matching entries (default: 0.02)
    - --save: save aligned second trajectory to disk (format: stamp2 x2 y2 z2)
    - --save_associations SAVE_ASSOCIATIONS: save associated first and aligned second trajectory to disk (format: stamp1 x1 y1 z1 stamp2 x2 y2 z2)
    - --plot PLOT: plot the first and the aligned second trajectory to an image (format: png)
    - --verbose: print all evaluation data (otherwise, only the RMSE absolute translational error in meters after alignment will be printed)

    ``` shell
    usage: evaluate_ate_scale.py [-h] [--offset OFFSET]
                                [--max_difference MAX_DIFFERENCE] [--save SAVE]
                                [--save_associations SAVE_ASSOCIATIONS]
                                [--plot PLOT] [--verbose]
                                first_file second_file
    ```

- AlignSimEfficient: 
    - The function of this script is the same as above, aligning trajectory with a sim(3) to compute ATE RMSE.

    ``` matlab
    [ rmse, RE, tE, scaleE ] = AlignSimEfficient( gtPos(:,2:4), traj(:,2:4) );
    ```

#### Evaluate trajectories for Kitti

[Lean More](Kitti-devkit/readme.txt)



