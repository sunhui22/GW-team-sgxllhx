%% Task: Generate a signal containing the sum of three sinusoids with
% the three sets parameters.

% Number of samples is 2048, sampling frequency: 1024 Hz, lasting 2 seconds.
sampFreq = 1024;
maxFreq = 300;
samplIntrvl = 1/sampFreq;
timeVec = 0:samplIntrvl:2.0;
% Number of samples
nSamples = length(timeVec);

% Gererate the signal
S1=10.*sin(2*pi*100.*timeVec);
S2=5.*sin(2*pi*200.*timeVec+pi/6);
S3=2.5.*sin(2*pi*300.*timeVec+pi/4);
S_bar = S1 + S2 + S3;

% Plot the signal
figure;
plot(timeVec,S_bar);

%Plot the periodogram
%------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
%Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% Design low pass filter
filt0rdr = 30;
b = fir1(filt0rdr,(maxFreq/2)/(sampFreq/2),'low');
% Apply filter
filtSig = fftfilt(b,S_bar);
% Discard negative frequencies
filtSig = filtSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(filtSig));