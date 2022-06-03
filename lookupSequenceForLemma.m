function [sequence,X_size,Y_size] = lookupSequenceForLemma(lemma)
    load("lemmas_lookup_table.mat","lookup_table_words","lookup_table_seqs","lookup_table_X_sizes","lookup_table_Y_sizes")
    index=find(lookup_table_words==lower(lemma));
    disp(index)
    sequence=lookup_table_seqs(index);
    X_size=str2num(lookup_table_X_sizes(index));
    Y_size=str2num(lookup_table_Y_sizes(index));
end