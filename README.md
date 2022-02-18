# GW-team-sgxllhx
Team members:Hui Sun, Shuo Guan, Zhongxiu Xu, Bing Lv, Lintao Liu, Yuxuan Hao, Junlan Xian
## Topic2
Fcross and Fplus:  

<img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/%E6%88%AA%E5%B1%8F2022-02-18%2022.41.51.png" width="300"/> <img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/%E6%88%AA%E5%B1%8F2022-02-18%2022.42.11.png" width="300"/>

## Topic3  
### lab1  
Use customrand and customrandn functions to generate 10,000 trials values each from U(x;-2,1) and N(x;1.5,2.0). And make normalized histograms for each case:  

<img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a1.png" width="300"/> <img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a2.png" width="300"/>  
### lab2  
We have been provided a plain text file: “testData.txt” in the NOISE folder: First column: sampling times u .Second column: data values. The data contains a realization of colored Gaussian noise plus a mystery signal added after t = 5.0 sec.  
Use the estimated PSD and emulate the code in NOISE/statgaussnoisegen.m to design whitening filter. After whitening, we plot the spectrograms of the data before and after whitening. The signal is clearer after whitening: 

<img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a3.png" width="300"/> <img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a4.png" width="300"/>    
Then we plot data time series before and after whitening. The presence of the signal is not clearer in the data after whitening in the time series:   

<img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a5.png" width="300"/> <img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a6.png" width="300"/>    
## Topic4
### Set1  
We start a new script SNRcalcMod1.m to calculate the SNR of the data containing our assigned  Sine-Gaussian signal. We plot the data (signal+noise) realization and the signal in the time domain, the periodogram of the signal and data, and the spectrogram of the data:  

<img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a7.png" width="300"/> <img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a8.png" width="300"/>   <img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a9.png" width="300"/>  

### Set2  
We start a new script SNRcalcMod2.m to work with our Sine-Gaussian assigned signal and the initial LIGO design sensitivity PSD. The estimated SNR of the LR test is 9.9631, which is close to the set SNR 10:

<img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a10.png" width="300"/> <img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a11.png" width="300"/>   <img src="https://github.com/sunhui22/GW-team-sgxllhx/blob/main/figures/a12.png" width="300"/>  



## Topic5

## Topic6

