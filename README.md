# RUL Estimation and Predictive Control of Floating Offshore Wind Turbines

### Table of Contents
- [Introduction](#introduction)
- [Installation guide](#Installation-guide)
- [Simulation Configuration](#Simulation-Configuration)
- [Part 1: Prediciton Model](#Part-1-State-Prediction-Model-using-MLSTM-model-based-on-Incoming-Waves)
- [Part 2: Fatigue model for RUL Estimation and Monitoring](#Part-2-Fatigue-model-for-RUL-Estimation-and-Monitoring)
- [Part 3: Live Monitoring](#Part-3-Live-Monitoring)
- [Acknowledgements](#Acknowledgements)

## Introduction
This project integrates an MLSTM model with OpenFAST and ROSCO to predict the future response of a FOWT, specifically the VolturnUS-S semi-submersible platform coupled with the IEA 15-MW Reference Wind Turbine. The integrated framework consists of a Multiplicative Long Short-Term Memory (MLSTM) neural network for state predictions model based on incoming waves, and a fatigue model for RUL estimations of tower base and blade roots, and a website for live monitoring. All development is integrated with the Reference Open-Source Controller (ROSCO) in OpenFAST. A website is also developed for real-time monitoring of the models and simulated operational data from OpenFAST.

## Installation guide

### Ubuntu

The models use ZeroMQ for data communication with ROSCO, requiring Ubuntu or similar. We recommend using a windows subsystem for Linux (WSL), for example the Visual Studio Code WSL extension:

https://code.visualstudio.com/docs/remote/wsl

### Miniconda

Within the WSL, we recommend installing miniconda or similar as a Python environment:

https://docs.anaconda.com/free/miniconda/

### FOWT_Digital_Twin_ROSCO installation

If using a Conda or Miniconda, do this within the respective conda folder or environment
(e.g. within the authors' setup with miniconda, the working directory is: \\wsl.localhost\Ubuntu\home\hpsauce\miniconda3).
 
1. Create a conda environment for ROSCO.

  ```python
  conda config --add channels conda-forge # (Enable Conda-forge Channel For Conda Package Manager)
  conda create -y --name DT-zmq-env python=3.10 # (Create a new environment named "DT-zmq-env" that contains Python 3.10)
  conda activate DT-zmq-env # (Activate your "DT-zmq-env" environment)
  ```
2. Install OpenFAST within the new environment (DT-zmq-env)
  ```python
  conda install -c conda-forge openfast
  ```
  ```python
  which openfast # Check that openfast installed properly
  openfast -v # Test
  ```

3. Clone and Install FOWT_Digital_Twin_ROSCO
  ```python
  git clone https://github.com/HPtharaldsen/FOWT_Digital_Twin_ROSCO.git
  ```
4. Install necessary requirements
  ```python
  cd FOWT_Digital_Twin_ROSCO # Change to correct directory
  pip install -r requirements.txt
  conda install -c anaconda tk
  ```
5. Run simulation

   ```python
   cd Digital_Twin_ZMQ # Change directory to run the digital twin w/ ZeroMQ
   ```
   Run Driver.py (Tip: for efficient testing, set '"WvDiffQTF": "False" and"WvSumQTF":  "False"' in lines 246 and 247)
   
   Example line for running Driver.py w/ miniconda:
   ```python
   /home/username/miniconda3/envs/DT-zmq-env/bin/python /home/username/miniconda3/FOWT_Digital_Twin_ROSCO/Digital_Twin_ZMQ/Driver.py
   ```


## Simulation Configuration

In order to configurate the main parameters for simulation, the `Driver.py`-script within 'Digital_Twin_ZMQ/' contains options for choosing pre-defined sea states, and activating the prediction model and the fatigue model.

Select pre-defined sea state for efficient demo of simulations.
  ```python
  self.Sea_State = 2  # Sea state selection: 1; Hs = 1, Tp = 4.5 - 2; Hs = 2, Tp = 5.5 - 3; Hs = 3.5, Tp = 6.5
   ``` 


Activate Prediction model:
  ```python
  self.Activate_Prediction_Model = True  # Activate prediction model for prediction of future states based on incoming waves
  ``` 
Activate Fatigue model:
  ```python
  self.Activate_Fatigue_Model = True  # Activate fatigue model for live RUL Estimation of Tower Base and Blade Roots
  ``` 

## Part 1: State Prediction Model using MLSTM-model based on Incoming Waves

This repository contains the implementation of a predictive control framework for a floating offshore wind turbine (FOWT) using an MLSTM model. The primary objective for the predictive model is to set the framework for future applications for implementing MLSTM-prediction in the ROSCO controller during simulation. For this specific example, collective blade pitch angle is predicted, thereby laying the framework for future optimization of the ROSCO controller using future predictions, and sending setpoints to the ROSCO controller's collective blade pitch controller. The existing MLSTM model and framework is located within 'Digital_Twin_ZMQ/Prediction_Model/DOLPHINN', and where the majority of the contents are developed by doctoral candidate Yuksel R. Alkarem from UMaine. His work is retrieved from https://github.com/Yuksel-Rudy/DOLPHINN.git.


### Blade Pitch Prediction Architecture

The MLSTM-WRP model is integrated with OpenFAST and ROSCO through a series of scripts and configurations:

- `Driver.py`: Main script to configure and run the OpenFAST simulation with the prediction model.
- `Blade_Pitch_Prediction`: Folder containing prediction model scripts, as listed below.
- `pitch_prediction.py`: Contains the logic for accumulating data batches and interfacing with the MLSTM model.
- `prediction_functions.py`: Utility functions such as buffering\saturating prediction offsets, plotting and saving data. 
- `wave_predict.py`: Script developed in collaboration with Yuksel R. Alkarem for wave prediction.
- `DOLPHINN`: An MLSTM framework developed by Yuksel R. Alkarem for predicting FOWT behavior based on incoming wave data.

### Measurement states used from ROSCO for training and prediction:

- 'BlPitchCMeas': Collective Blade Pitch Angle
- 'PtfmTDX': Surge
- 'PtfmTDZ': Heave
- 'PtfmTDY': Sway
- 'PtfmRDX': Roll
- 'PtfmRDY': Pitch
- 'PtfmRDZ': Roll
  

### Prediction Model Usage with OpenFAST:

Specify Prediction model configuration during simulation in the `wfc_controller` in `Driver.py`:

- Specify which FOWT state to use for prediction and monitoring. Choosing "BlPitchCMeas" allows for Buffer and Saturate-initiation, while other DOFS only provide prediction and monitoring:
    ```python
    FOWT_pred_state = 'BlPitchCMeas'
     ```
- Specify wind speeds within the sim_openfast_custom-function:
    ```python
        if self.steady_wind:
            r.wind_case_opts.update({"wind_type": 1, "HWindSpeed": 12.5})   # Change 12.5 to desired steady wind speed
        else:
            r.wind_case_opts.update({"turb_wind_speed": "20"})              # Change 20 to desired turbulent wind speed
       ```

- Specify trained MLSTM-model:
    ```python
    MLSTM_MODEL_NAME = TrainingData_Hs_2_75_Tp_6 # Trained MLSTM model
     ```

- Make sure that the `WAVE_DATA_FILE` is a csv-timeseries, matching the sea state specified in Load Case:
    ```python
    WAVE_DATA_FILE = WaveData_LC2 # Example wave file for LC2
     ```
- To send offset between blade pitch MLSTM-prediction and actual blade pitch angle:
    ```python
    Prediction = True 
     ```
    
-  For real time prediction plotting:
    ```python
    plot_figure = True
     ```

- To saturate offset between prediction and actual measurement:
    ```python
    Pred_Saturation = True
     ```

- If observing an amplitude offset between prediction and measurement, an error may be defined to correct the predictions:
    ```python
    pred_error = 1.4 # [deg]
     ```

#### MLSTM model training:

In order to train a custom MLSTM-model, this is done by running the following script:

`/ROSCO/Digital_Twin_ZMQ/Blade_Pitch_Prediction/DOLPHINN/examples/01a_wave_train.py`

Specify training data and parameters in:

`/ROSCO/Digital_Twin_ZMQ/Blade_Pitch_Prediction/DOLPHINN/dol_input/training_param.yaml`

## Part 2: Fatigue Estimation Model

This repository contains the implementation and usage of a fatigue model for RUL estimation. 

### Fatigue Estimation Model Architecture
The Fatigue Estimation Model consists of:
- **fatigue_damage_RUL.py**: Updates measurements, performs rainflow counting on stress history, calculates fatigue damage, and estimates RUL.
- **stress_history.py**: Gathers stress data in real time.

### Integration with Simulation
Configure the `Driver.py` script to activate the fatigue model:
```python
self.Activate_Fatigue_Model = True  # Enable fatigue model
 ```
## Part 3: Live Monitoring

This repository contains the implementation and usage of a live monitoring system, which provides real-time updates on the turbine's operational status, predicted component RUL and blade pitch angle predictions based on incoming waves.

### Live Monitoring Architecture
The live monitoring system consists of:
- **real_time_server.py**: A script that serves real-time data to the webpage.
- **webpage.html**: The HTML file that displays the live data.

### Running the Live Monitoring System
1. **Run the Real-Time Server**: Open a terminal and start the `real_time_server.py` script to begin serving data.
    ```python
    python real_time_server.py  # Start the real-time server
    ```
2. **Run Driver Script**: Ensure `Driver.py` is running simultaneously in a separate terminal.
    ```python
    python Driver.py  # Start the driver script
    ```
3. **Access the Monitoring Webpage**: Open a web browser and navigate to [http://localhost:5005/](http://localhost:5005/) to view live updates.

## Acknowledgements

This project includes code from the following repositories:

- **NUWind Project**: This project has been conducted as a collaboration between the Norwegian University of Science & Technology (NTNU) and the University of Maine (UMaine), enabling students to collaborate and research the field of offshore wind.
- **[DOLPHINN](https://github.com/Yuksel-Rudy/DOLPHINN)**: An MLSTM framework developed by Yuksel R. Alkarem for predicting FOWT behavior based on incoming wave data. Most of the contents in the `Digital_Twin_ZMQ/Prediction_Model/DOLPHINN` folder are developed by Yuksel R. Alkarem.
- **[NREL/ROSCO](https://github.com/NREL/ROSCO)**: The ROSCO controller code and examples are retrieved from the National Renewable Energy Laboratory's ROSCO repository.
  
Special thanks to NTNU, UMaine, Yuksel R. Alkarem and the NREL ROSCO development team for their contributions.


