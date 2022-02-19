%% Generate values
dataRand=customrand(-2,1);
dataRandn=customrandn(1.5,2.0);
%% Make normalized histograms for each case
figure;
histogram(dataRand,'normalization','pdf');
title('U(x;-2,1)');
figure;
histogram(dataRandn,'normalization','pdf');
title('N(x;1.5,2.0)');