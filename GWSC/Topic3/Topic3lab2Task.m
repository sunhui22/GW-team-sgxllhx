
%%
% Path to folder containing signal and noise generation codes
addpath ../Topic1
addpath ../SIGNALS
addpath ../NOISE
addpath ../DETEST
%% load
dataVec=load('testData.txt');
noiseVec=testData(1:5121,:)';
timeVec=noiseVec(1,:);
noiseVec=noiseVec(2,:);
%Sampling frequency for noise realization
sampFreq = 1024; %Hz
%%
% Estimate the PSD
% (Pwelch plots in dB (= 10*log10(x)); plot on a linear scale)
[psdVec,freqVec]=pwelch(noiseVec, 256,[],[],sampFreq);
figure;
plot(freqVec,psdVec);
xlabel('Frequency (Hz)');
ylabel('PSD');
% Plot the colored noise realization
figure;
plot(timeVec,noiseVec);
%% Generate whiten data
fltrOrdr = 500;
whitenData = whiteningfilter(dataVec(:,2),[freqVec(:),psdVec(:)],fltrOrdr,sampFreq);
figure;
plot(whitenData);
%% Plot a spectrogram
%---------------
winLen = 0.1;%sec
ovrlp = 0.05;%sec
%Convert to integer number of samples
winLenSmpls = floor(winLen*sampFreq);
ovrlpSmpls = floor(ovrlp*sampFreq);
[S,F,T]=spectrogram(dataVec(:,2),winLenSmpls,ovrlpSmpls,[],sampFreq);
figure;
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
[S1,F1,T1]=spectrogram(whitenData,winLenSmpls,ovrlpSmpls,[],sampFreq);
figure;
imagesc(T1,F1,abs(S1));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');