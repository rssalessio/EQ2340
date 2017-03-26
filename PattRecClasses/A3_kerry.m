q = [1 0 0]';
A = [.3 .7 0; 0 .5 .5; 0 0 1];
B = [1 0 0 0; 0 .5 .4 .1; .1 .1 .2 .6];
z = [1 2 4 4 1];
c = [1 .35 .35 (79/140) .0994];
mc = MarkovChain(q, A);

nS = size(A, 1);
T = length(z);

pX = zeros(nS, T);
for t = 1:T
    z_t = z(t);
    pX(:, t) = B(:, z_t);
end

% gives the same answer as my manually calculated results
backward(mc, pX, c)
%ans =
%    0.9997    0.3311    0.1783    5.3485   10.0604
%    0.9760    2.8562    1.6555    0.8914   10.0604
%    0.5239    5.2394    3.0563    1.7828   10.0604