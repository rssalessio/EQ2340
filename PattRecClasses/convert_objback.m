function hmm = convert_objback(hmm,in)

for first = 1:size(in,1)
    for second= 1:size(in,2)
        hmm.OutputDistr(first).Gaussians(second).Variance = in{first,second,1};
        hmm.OutputDistr(first).Gaussians(second).StDev = in{first,second,2};
        hmm.OutputDistr(first).Gaussians(second).Covariance = in{first,second,3};
    end
end
end