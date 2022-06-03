function gesture=drawSenteceGesture(lemmas,phrases,meta_datas,POS)
gesture.X_positions=[];
gesture.Y_positions=[];
gesture.dir_sequence=[];
% gesture.angular_vel=0;
% gesture.t_render=3;
% gesture.data_density=0.5;
constituents=[];
for i=1:length(lemmas)
    disp("---")
    disp(string(phrases(i)))
    constituents(i).X_positions=[];
    constituents(i).Y_positions=[];
    constituents(i).dir_sequence=[];
    constituents(i).X_constrained=0;
    constituents(i).Y_constrained=0;
%     Set origin for gesture
    X_origin_constituent=5;
    Y_origin_constituent=1+(i-1)*7;
    [seq,X_size,Y_size]=lookupSequenceForLemma(lemmas(i));
    X_origin_constituent=5-floor(X_size/2); 
    Y_origin_constituent=4+(i-1)*7-floor(Y_size/2);

%     Generate gesture from dir sequence
    seq=str2mat(seq);
    seq(seq=='S'|seq=='E')=[];
    start_dir=str2double(seq(1));
    seq=seq(2:end);
    constituents(i).dir_sequence(1)=start_dir;
    for iter=1:length(seq)
        dirs = [1 2 3 4 5 6 7 8];
        dirs=circshift(dirs,-start_dir+1);
        shift_by=str2double(seq(iter));
        shifted_dirs=circshift(dirs,shift_by);
        constituents(i).dir_sequence(end+1)=shifted_dirs(1);
        start_dir=shifted_dirs(1);
    end    

%     Add grammatizations
    if(strcmp(POS(i),'Verb'))
        disp("is verb")
        if isfield(meta_datas{1,i},'Tense')&&(strcmp(meta_datas{1,i}.Tense,'Pres'))
            disp("and is present tense")
            constituents(i).dir_sequence=horzcat([5 5],constituents(i).dir_sequence);
        end
        if isfield(meta_datas{1,i},'Tense')&&(strcmp(meta_datas{1,i}.Tense,'Past'))
            disp("and is present tense")
            constituents(i).dir_sequence=horzcat([6 6],constituents(i).dir_sequence);
        end
    end
    if(strcmp(POS(i),'Noun'))
        disp("is noun")
    end
    if(strcmp(POS(i),'Adverb'))
        disp("is adverb")
    end
    if(strcmp(POS(i),'Adjective'))
        disp("is adjective")
    end
    if(strcmp(POS(i),'Pronoun'))
        disp("is pronoun")
        if isfield(meta_datas{1,i},'Number') && (strcmp(meta_datas{1,i}.Number,'Sing'))
            disp("and is Singular")
        end
        if isfield(meta_datas{1,i},'Number') && (strcmp(meta_datas{1,i}.Number,'Plur'))
            disp("and is Plural")
        end
        if isfield(meta_datas{1,i},'Person') && (strcmp(meta_datas{1,i}.Person,'1'))
            disp("and is First Person")
            constituents(i).X_constrained=1;  
            X_origin_constituent=1;
        end
        if isfield(meta_datas{1,i},'Person') && (strcmp(meta_datas{1,i}.Person,'2'))
            disp("and is Second Person")
            X_origin_constituent=5;
            constituents(i).X_constrained=1;  
        end
        if isfield(meta_datas{1,i},'Person') && (strcmp(meta_datas{1,i}.Person,'3'))
            disp("and is Third Person")
            X_origin_constituent=9;
            constituents(i).X_constrained=1;  
        end
    end
    if(strcmp(POS(i),'Adjective'))
        disp("is adjective")
    end


%     Generate constituent gesture 
    constituents(i).X_positions(1)=X_origin_constituent;
    constituents(i).Y_positions(1)=Y_origin_constituent;
    for step=2:length(constituents(i).dir_sequence)
        prop_dir=constituents(i).dir_sequence(step);
        if prop_dir<5 && prop_dir>1
            constituents(i).X_positions(end+1)=constituents(i).X_positions(end)+1;
        end
        if prop_dir>5 && prop_dir<9
            constituents(i).X_positions(end+1)=constituents(i).X_positions(end)-1;
        end
        if prop_dir<7 && prop_dir>3
            constituents(i).Y_positions(end+1)=constituents(i).Y_positions(end)+1;
        end
        if prop_dir<3 || prop_dir>7
            constituents(i).Y_positions(end+1)=constituents(i).Y_positions(end)-1;
        end
        if prop_dir==1 || prop_dir==5
            constituents(i).X_positions(end+1)=constituents(i).X_positions(end);
        end
        if prop_dir==7 || prop_dir==3
            constituents(i).Y_positions(end+1)=constituents(i).Y_positions(end);
        end
    end
    constituents(i).X_centroid=calcCentroid(constituents(i).X_positions);
    constituents(i).Y_centroid=calcCentroid(constituents(i).Y_positions);
    disp("Begining direction:")
    disp(constituents(i).dir_sequence(1))
    disp("Ending direction:")
    disp(constituents(i).dir_sequence(end))
    disp("X_constrained")
    disp(constituents(i).X_constrained)
    if i>=2
        if(constituents(i).X_constrained==0 )
            X_shift=0;
            if(constituents(i-1).X_positions(end)<=constituents(i).X_positions(1))
                shifts=[constituents(i-1).X_positions(end)-constituents(i).X_positions(1) 1-min(constituents(i).X_positions)];
                X_shift=max(shifts);
            end
            if(constituents(i-1).X_positions(end)>constituents(i).X_positions(1))
                shifts=[constituents(i-1).X_positions(end)-constituents(i).X_positions(1) 9-max(constituents(i).X_positions)];
                X_shift=min(shifts);
            end
            constituents(i).X_positions=constituents(i).X_positions+X_shift;
            disp("X_shift")
            disp(X_shift)
        end  
    end
%     Add consitituent to overall gesture
    gesture.X_positions=horzcat(gesture.X_positions,constituents(i).X_positions);
    gesture.Y_positions=horzcat(gesture.Y_positions,constituents(i).Y_positions);
    gesture.dir_sequence=horzcat(gesture.dir_sequence,constituents(i).dir_sequence);
end
  
% gesture.X_positions=[1 2 3];
% gesture.Y_positions=[1 2 3];
gesture.angular_vel=0;
gesture.t_render=3;
gesture.data_density=0.5;
end