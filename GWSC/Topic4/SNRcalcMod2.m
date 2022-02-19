%% How to normalize a signal for a given SNR
% We will normalize a signal such that the Likelihood ratio (LR) test for it has
% a given signal-to-noise ratio (SNR) in noise with a given Power Spectral 
% Density (PSD). [We often shorten this statement to say: "Normalize the
% signal to have a given SNR." ]

%%
% Path to folder containing signal and noise generation codes
addpath ../Topic1
addpath ../SIGNALS
addpath ../NOISE
addpath ../DETEST

%%
% This is the target SNR for the LR
snr = 10;

%%
% Data generation parameters
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;


%%
% Generate the signal that is to be normalized
a1=1.2;
a2=0.2;
a3=30;
a4=0;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; 
sigVec = sigaus(timeVec,1,[a1,a2,a3,a4]);

%%
% We will set the noise PSD as initial LIGO design sensitivity PSD.
% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
noisePSD = load('iLIGOSensitivity.txt','-ascii');
noisePSD = interp1(noisePSD(:,1)',noisePSD(:,2)',posFreq(3:end),'linear');
psdPosFreq = [noisePSD(99).*ones(1,100),noisePSD(99:end)];
% Sn_50 = (50-noisePSD2(42,1))*(noisePSD2(43,2)-noisePSD2(42,2))/(noisePSD2(43,1)-noisePSD2(42,1))+noisePSD2(42,2);
% Sn_PosFreq = ((kNyq-1)*(1/dataLen)-noisePSD2(66,1))*(noisePSD2(67,2)-noisePSD2(66,2))/(noisePSD2(67,1)-noisePSD2(66,1))+noisePSD2(66,2);
% noisePSD1 = Sn_50*ones(50,1);
% posFreq = [[0:49]';50;noisePSD2(43:66,1);500]';
% psdPosFreq = [Sn_50.*ones(50,1);Sn_50;noisePSD2(43:66,2);Sn_PosFreq]';

% %% Generate noise realization
% fltrOrdr = 500;
% outNoise = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],fltrOrdr,sampFreq);

% %% Figure
% figure;
% plot(posFreq,psdPosFreq);
% axis([0,posFreq(end),0,max(psdPosFreq)]);
% xlabel('Frequency (Hz)');
% ylabel('PSD ((data unit)^2/Hz)');

%% Calculation of the norm
% Norm of signal squared is inner product of signal with itself
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
% Normalize signal to specified SNR
sigVec = snr*sigVec/sqrt(normSigSqrd);

%% Test
%Obtain LLR values for multiple noise realizations
nH0Data = 1000;
llrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    llrH0(lp) = innerprodpsd(noiseVec,sigVec,sampFreq,psdPosFreq);
end
%Obtain LLR for multiple data (=signal+noise) realizations
nH1Data = 1000;
llrH1 = zeros(1,nH1Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    % Add normalized signal
    dataVec = noiseVec + sigVec;
    llrH1(lp) = innerprodpsd(dataVec,sigVec,sampFreq,psdPosFreq);
end
%%
% Signal to noise ratio estimate
estSNR = (mean(llrH1)-mean(llrH0))/std(llrH0);

%%
% A data realization
figure;
plot(timeVec,dataVec);
hold on;
plot(timeVec,sigVec);
xlabel('Time (sec)');
ylabel('Data');

%% Plot the periodogram
%------------
% FFT of signal and data
fftSig = fft(sigVec);
fftData = fft(dataVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);
fftData = fftData(1:kNyq);
%Plot periodogram
figure;
plot(posFreq,abs(fftSig));
hold on;
plot(posFreq,abs(fftData));

%% Plot a spectrogram
%---------------
winLen = 0.1;%sec
ovrlp = 0.05;%sec
%Convert to integer number of samples
winLenSmpls = floor(winLen*sampFreq);
ovrlpSmpls = floor(ovrlp*sampFreq);
[S,F,T]=spectrogram(dataVec,winLenSmpls,ovrlpSmpls,[],sampFreq);
figure;
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');