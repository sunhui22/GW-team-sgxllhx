%% Plot the Sine-Gaussian signal
% Signal parameters
a1=1.2;
a2=0.2;
a3=30;
a4=0;
A=10;
% Instantaneous frequency after 1 sec is 
maxFreq = a3;
samplFreq = 10*maxFreq;
samplIntrvl = 1/samplFreq;

%Time samples
timeVec = 0:samplIntrvl:2.0;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = sigaus(timeVec,A,[a1,a2,a3,a4]);

%Plot the signal
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',1);

%Plot a spectrogram
%---------------
winLen = 0.1;%sec
ovrlp = 0.05;%sec
%Convert to integer number of samples
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

%Plot the periodogram
%------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
%Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));