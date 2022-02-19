%%
% Path to folder containing signal and noise generation codes
addpath ../Topic1
addpath ../SIGNALS
addpath ../NOISE
addpath ../DETEST
%% load the data
load('data1.txt');
load('data2.txt');
load('data3.txt');
plot(data1);
hold on;
plot(data2);
hold on;
plot(data3);
%%
% Data generation parameters
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;
%%
% Generate the signal that is to be normalized
a1=10;
a2=3;
a3=3;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; 
sigVec = crcbgenqcsig(timeVec,A,[a1,a2,a3]);
%%
% We will use the noise PSD used in colGaussNoiseDemo.m but add a constant
% to remove the parts that are zero. (Exercise: Prove that if the noise PSD
% is zero at some frequencies but the signal added to the noise is not,
% then one can create a detection statistic with infinite SNR.)
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;

%%
% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

%% Calculation of the norm
% Norm of signal squared is inner product of signal with itself
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
% Normalize signal to specified SNR
sigVec = sigVec/sqrt(normSigSqrd);
%% Test
%Obtain LLR values for multiple noise realizations
nH0Data = 1000;
llrH0 = zeros(1,nH0Data);
llrH1 = zeros(1,nH0Data);
llrH2 = zeros(1,nH0Data);
llrH3 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    llrH0(lp) = innerprodpsd(noiseVec,sigVec,sampFreq,psdPosFreq);
    llrH1(lp) = innerprodpsd(data1',sigVec,sampFreq,psdPosFreq);
    llrH2(lp) = innerprodpsd(data2',sigVec,sampFreq,psdPosFreq);
    llrH3(lp) = innerprodpsd(data3',sigVec,sampFreq,psdPosFreq);
end

%% Signal to noise ratio estimate
estSNR1 = (mean(llrH1)-mean(llrH0))/std(llrH0);
estSNR2 = (mean(llrH2)-mean(llrH0))/std(llrH0);
estSNR3 = (mean(llrH3)-mean(llrH0))/std(llrH0);
%% Use glrtqcsig.m to calculate the GLRT for each of the 3 data realizations
glrt1 = glrtqcsig(data1', psdPosFreq, [a1,a2,a3]);
glrt2 = glrtqcsig(data2', psdPosFreq, [a1,a2,a3]);
glrt3 = glrtqcsig(data3', psdPosFreq, [a1,a2,a3]);
