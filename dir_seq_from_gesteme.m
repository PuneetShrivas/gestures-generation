function dir_seq=dir_seq_from_gesteme(gestemes,curr_dir,gest_ID)
    insert_gesteme = str2mat(string(gestemes(gest_ID).seq));
    insert_gesteme(insert_gesteme=='S'|insert_gesteme=='E')=[];
    app_dir_seq = [];
    for k=1:length(insert_gesteme)
        dirs = [1 2 3 4 5 6 7 8];
        dirs=circshift(dirs,-curr_dir+1);
        shift_by=str2num(insert_gesteme(k));
        shifted_dirs=circshift(dirs,shift_by);
        app_dir_seq(end+1)=shifted_dirs(1);
        curr_dir=shifted_dirs(1);
    end
    dir_seq=(app_dir_seq);
end