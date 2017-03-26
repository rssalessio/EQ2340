function hmm_save = convert_obj(hmm)
    for first = 1:length(hmm.OutputDistr)
        %hmm_save{first,1,1} = hmm.OutputDistr.Covariance;
        for second= 1:length(hmm.OutputDistr(first).Gaussians)
            hmm_save{first,second,1} = hmm.OutputDistr(first).Gaussians(second).Variance;
            hmm_save{first,second,2} = hmm.OutputDistr(first).Gaussians(second).StDev;
            hmm_save{first,second,3} = hmm.OutputDistr(first).Gaussians(second).Covariance;
        end
    end
end