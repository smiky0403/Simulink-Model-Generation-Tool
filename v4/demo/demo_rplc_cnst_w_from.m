clc
clear

%Author:
%       Mingqi Shi, mingqis qti qm
%
%Created:
%       2023-08-25

% Before using this code:
% 1) Open a model, create serveral demo constants with names/labels,
% 2) Connect to a bus creator and 
% 3) connect it to a Goto block
% Then proceed below:

sigs = get_cnsts();

%move to a desired subsystem where to relace all const blocks inside

[sigs_pool, paths_pool] = get_cnsts(gcs, 1);

for i = 1:length(sigs)
    sig = sigs{i};
    idxs = find(strcmp(sig, sigs_pool));
    
    if(isempty(idxs))
        continue;
    else
        
        % Replace individual cnst to from block or from block +
        % bus_selector
        % Depends on work or customer need

         for j = 1: length(idxs)
             idx = idxs(j);   %i.e. more than one places have same signals names
             sig_pool = sigs_pool{idx};
             path_pool = paths_pool{idx};
             [~, clauses] = regexp(path_pool, '/', 'match', 'split');
             sig_dir = strjoin(clauses(1: length(clauses) -1),'/');

             uncnct_blks2bus(sig_dir , sig_pool);
             pos = get_param(path_pool, 'Position');
             delete_block(path_pool)

             %option 1: individual goto blocks
             create_fromblks(sig_dir , sig_pool);
             set_param(strcat(path_pool, '_from'), 'Position', pos);

              %Work Paused here, 1) bus creator missing port 
              % 2) which bus creator    
              
             %cnct_blks2bus(sig_dir ,sig_pool, 'bus_creator')

         end


    end


end