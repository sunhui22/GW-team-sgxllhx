function dataRand=customrand(a,b)
% Generate 10000 datas which obey the uniform PDF U(a,b).
% dataRand=customrand(a,b)
% input: [a,b] is the range the datas will generate from.
% output: 10000 datas
M=10000;
X=rand(1,M);
dataRand=(b-a).*X+a;
end