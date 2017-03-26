function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors: Alessio Russo(911103-T192), Lars Lindemann (891113-4131) 
%----------------------------------------------------

    % Code should also work for more than one feature! Iterate through features
    numFeatures = numel(pD);
    R           = zeros(numFeatures,nData);

    type = 'wheel';

    if strcmp(type,'wheel')
        for i=1:numFeatures
            %cumsum(ProbMass,1): returns the CDF of the discrete. distr.
            %rand: samples from the uniform distribution (0,1)
            %histc: uses as x axis the one defined by cumsum, then for each
            % random sample it sees to which x corresponds. 1 is added in
            % the end otherwise results start from 0(may casue a vector indexing
            % problem if you use the result of this function as index of another vector)
            [~,index]   = histc(rand(1,nData),cumsum(full(pD(i).ProbMass),1)); 
            R(i,:)      = index+1;
        end
    else
        %the alias method may be implemented, works by creating a box of
        %area =1 where it is divided in subareas based on the probability
        %mass, then we uniformly sample from the area and see in which
        %subarea the sample belongs to.
        disp('Method [' + type + '] for discrete sampling not implemented');
    end

end