function [training_f,validation_f,length_training,length_validation] = kfold(i,features,nWords,nPeople)


k = 5;
counter = 1;
counter1 = 1;
nSamples = 15;
training_s = [];
validation_s = [];
    
if i == 1
    % perform for 15 sample people
    for j=1:nWords
        for i=1:nPeople
            for kk=1:nSamples
                if kk<=(k-1)*nSamples/k
                    training_s = [training_s features{j,i,kk}];
                    length_training(j,counter) = size(features{j,i,kk},2);
                    counter = counter + 1;
                else
                    validation_s = [validation_s features{j,i,kk}];
                    length_validation(j,counter1) = size(features{j,i,kk},2);
                    counter1 = counter1 + 1;
                end 
            end
        end  
%         nSamples = 10;
%         for i=5:5
%             for kk=1:nSamples
%                 if kk<=8
%                     training_s = [training_s features{j,i,kk}];
%                     length_training(j,counter) = size(features{j,i,kk},2);
%                     counter = counter + 1;
%                 else
%                     validation_s = [validation_s features{j,i,kk}];
%                     length_validation(j,counter1) = size(features{j,i,kk},2);
%                     counter1 = counter1 + 1;
%                 end 
%             end
%         end  
        training_f{j} = training_s;
        training_s = [];
        validation_f{j} = validation_s;
        validation_s = [];
        counter = 1;
        counter1 = 1;
    end
    
elseif i == 2
    % perform for 15 sample people
    for j=1:nWords
        nSamples = 15;
        for i=1:nPeople
            for kk=1:nSamples
                if kk<=9 || kk>=13
                    training_s = [training_s features{j,i,kk}];
                    length_training(j,counter) = size(features{j,i,kk},2);
                    counter = counter + 1;
                else
                    validation_s = [validation_s features{j,i,kk}];
                    length_validation(j,counter1) = size(features{j,i,kk},2);
                    counter1 = counter1 + 1;
                end 
            end
        end  
%         nSamples = 10;
%         for i=5:5
%             for kk=1:nSamples
%                 if kk<=6 || kk>=9
%                     training_s = [training_s features{j,i,kk}];
%                     length_training(j,counter) = size(features{j,i,kk},2);
%                     counter = counter + 1;
%                 else
%                     validation_s = [validation_s features{j,i,kk}];
%                     length_validation(j,counter1) = size(features{j,i,kk},2);
%                     counter1 = counter1 + 1;
%                 end 
%             end
%         end  
        training_f{j} = training_s;
        training_s = [];
        validation_f{j} = validation_s;
        validation_s = [];
        counter = 1;
        counter1 = 1;
    end
    
elseif i==3
    % perform for 15 sample people
    for j=1:nWords
        nSamples = 15;
        for i=1:nPeople
            for kk=1:nSamples
                if kk<=6 || kk>=10
                    training_s = [training_s features{j,i,kk}];
                    length_training(j,counter) = size(features{j,i,kk},2);
                    counter = counter + 1;
                else
                    validation_s = [validation_s features{j,i,kk}];
                    length_validation(j,counter1) = size(features{j,i,kk},2);
                    counter1 = counter1 + 1;
                end 
            end
        end  
%         nSamples = 10;
%         for i=5:5
%             for kk=1:nSamples
%                 if kk<=4 || kk>=7
%                     training_s = [training_s features{j,i,kk}];
%                     length_training(j,counter) = size(features{j,i,kk},2);
%                     counter = counter + 1;
%                 else
%                     validation_s = [validation_s features{j,i,kk}];
%                     length_validation(j,counter1) = size(features{j,i,kk},2);
%                     counter1 = counter1 + 1;
%                 end 
%             end
%         end          
        training_f{j} = training_s;
        training_s = [];
        validation_f{j} = validation_s;
        validation_s = [];
        counter = 1;
        counter1 = 1;
    end
    
elseif i==4
    % perform for 15 sample people
    for j=1:nWords
        nSamples = 15;
        for i=1:nPeople
            for kk=1:nSamples
                if kk<=3 || kk>=7
                    training_s = [training_s features{j,i,kk}];
                    length_training(j,counter) = size(features{j,i,kk},2);
                    counter = counter + 1;
                else
                    validation_s = [validation_s features{j,i,kk}];
                    length_validation(j,counter1) = size(features{j,i,kk},2);
                    counter1 = counter1 + 1;
                end 
            end
        end  
%         nSamples = 10;
%         for i=5:5
%             for kk=1:nSamples
%                 if kk<=2 || kk>=5
%                     training_s = [training_s features{j,i,kk}];
%                     length_training(j,counter) = size(features{j,i,kk},2);
%                     counter = counter + 1;
%                 else
%                     validation_s = [validation_s features{j,i,kk}];
%                     length_validation(j,counter1) = size(features{j,i,kk},2);
%                     counter1 = counter1 + 1;
%                 end 
%             end
%         end          
        training_f{j} = training_s;
        training_s = [];
        validation_f{j} = validation_s;
        validation_s = [];
        counter = 1;
        counter1 = 1;
    end
   
else
    % perform for 15 sample people
    for j=1:nWords
        nSamples = 15;
        for i=1:nPeople
            for kk=1:nSamples
                if kk>=4
                    training_s = [training_s features{j,i,kk}];
                    length_training(j,counter) = size(features{j,i,kk},2);
                    counter = counter + 1;
                else
                    validation_s = [validation_s features{j,i,kk}];
                    length_validation(j,counter1) = size(features{j,i,kk},2);
                    counter1 = counter1 + 1;
                end 
            end
        end 
%         nSamples = 10;
%         for i=5:5
%             for kk=1:nSamples
%                 if kk>=3
%                     training_s = [training_s features{j,i,kk}];
%                     length_training(j,counter) = size(features{j,i,kk},2);
%                     counter = counter + 1;
%                 else
%                     validation_s = [validation_s features{j,i,kk}];
%                     length_validation(j,counter1) = size(features{j,i,kk},2);
%                     counter1 = counter1 + 1;
%                 end 
%             end
%         end          
        training_f{j} = training_s;
        training_s = [];
        validation_f{j} = validation_s;
        validation_s = [];
        counter = 1;
        counter1 = 1;
    end
   
end

end

    