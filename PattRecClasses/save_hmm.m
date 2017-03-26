%%
% in1 = convert_obj(hmm(1));
% in2 = convert_obj(hmm(2));
% in3 = convert_obj(hmm(3));
% in4 = convert_obj(hmm(4));
% in5 = convert_obj(hmm(5));
% in6 = convert_obj(hmm(6));
% in7 = convert_obj(hmm(7));
% in8 = convert_obj(hmm(8));
% in9 = convert_obj(hmm(9));
% in10 = convert_obj(hmm(10));
% in11 = convert_obj(hmm(11));
% in12 = convert_obj(hmm(12));
% in13 = convert_obj(hmm(13));
% in14 = convert_obj(hmm(14));
% 
% save('hmms5','in1','in2','in3','in4','in5','in6','in7','in8','in9',...
%     'in10','in11','in12','in13','in14');
% save('hmm5','hmm')

%%
load('hmm4');
load('hmms4');


hmm(1) = convert_objback(hmm(1),in1);
hmm(2) = convert_objback(hmm(2),in2);
hmm(3) = convert_objback(hmm(3),in3);
hmm(4) = convert_objback(hmm(4),in4);
hmm(5) = convert_objback(hmm(5),in5);
hmm(6) = convert_objback(hmm(6),in6);
hmm(7) = convert_objback(hmm(7),in7);
hmm(8) = convert_objback(hmm(8),in8);
hmm(9) = convert_objback(hmm(9),in9);
hmm(10) = convert_objback(hmm(10),in10);
hmm(11) = convert_objback(hmm(11),in11);
hmm(12) = convert_objback(hmm(12),in12);
hmm(13) = convert_objback(hmm(13),in13);
hmm(14) = convert_objback(hmm(14),in14);