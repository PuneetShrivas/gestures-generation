clc
fileObj = System.IO.FileSystemWatcher('C:\Users\punee\Python');
fileObj.Filter = '*.mat';
fileObj.EnableRaisingEvents = true;
addlistener(fileObj,'Changed',@eventhandlerChanged);

function eventhandlerChanged(src,~)
    disp("file changed")
    lemmas=load('C:\Users\punee\Python\res_from_python.mat','lemmas');
    meta_datas=load('C:\Users\punee\Python\res_from_python.mat','meta_datas');
    phrases=load('C:\Users\punee\Python\res_from_python.mat','phrases');
    POS=load('C:\Users\punee\Python\res_from_python.mat','POS');
    arg_lemmas={};
    arg_meta_datas={};
    arg_phrases={};
    arg_POS={};
    for i=1:size(lemmas.lemmas,1)   
        dummy_meta_datas={};
%         for j=1:length(meta_datas.meta_datas{1,i})
%             if isa(meta_datas.meta_datas{1,i}{1,j},"struct")
%                 disp(cell2mat(struct2cell(meta_datas.meta_datas{1,i}{1,j})))
% %                 dummy_meta_datas(end+1)=(meta_datas.meta_datas{1,i}{1,j});
%             end
%         end
        arg_meta_datas{i}=meta_datas.meta_datas{i}; 
        arg_lemmas{i}=strip(lemmas.lemmas(i,:));
        arg_phrases{i}=strip(phrases.phrases(i,:));
        arg_POS{i}=strip(POS.POS(i,:));
%         arg_meta_datas(end+1,:) = dummy_meta_datas;
    end
    gesture=drawSenteceGesture(arg_lemmas,arg_phrases,arg_meta_datas,arg_POS);
    disp("_________________________________")
    plot_gesture(gesture)
end

