function dataRandn=customrandn(a,b)
% Generate 10000 datas which obey the normal PDF U(a,b).
% dataRandn=customrandn(a,b)
% input: a is the average value, and b is the sigma.
% output: 10000 datas
M=10000;
dataRandn=normrnd(a,b,1,M);
end