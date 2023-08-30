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
cnt_grp = 0;

for i = 1:length(sigs)
    sig = sigs{i};
    idxs = find(strcmp(sig, sigs_pool));
    
    if(isempty(idxs))
        continue;
    else
        
        % Replace individual cnst to from block or from block +
        % bus_selector
        % Depends on work or customer need

         for j =  1: length(idxs)
             idx = idxs(j);   %i.e. more than one places have same signals names
             sig_pool = sigs_pool{idx};
             path_pool = paths_pool{idx};
             [~, clauses] = regexp(path_pool, '/', 'match', 'split');
             sig_dir = strjoin(clauses(1: length(clauses) -1),'/');

             [bus_cnnts, port_nums] = uncnct_blks2bus(sig_dir , sig_pool);
             port_num =  port_nums(1);
             bus_cnnt = bus_cnnts{1};

             pos = get_param(path_pool, 'Position');
             pos = [pos(1), pos(2) + 10, pos(3) + 50, pos(4) - 10];
             pos1 =  [pos(1) + 150, pos(2) pos(3) + 50 + 150 - 145, pos(4)];
             pos2 =  [ pos1(1) + 110, pos1(2),pos1(3) + 150, pos1(4) ];
            
             delete_block(path_pool)

             %-----option 1: individual goto blocks-------

              %  %1) create fromblock
             % create_fromblks(sig_dir , sig_pool);   
             % 
             % set_param(strcat(path_pool, '_from'), 'Position', pos);
             % 
              %  %2) connect from block to port on the bus
             % if(port_nums(1) > 0 )

             %     %???
             %     cnct_blks2bus(sig_dir, strcat(sig_pool, '_from'),...
             %     bus_cnnt, [port_num], sig_pool);
             % else
             %    disp(['The block of ', sig_pool, ...
             %        ' was not connect to any other other port before'])
             % end
             

             %----option 2: grouped goto blocks---------
               % 1) create fromblock
               sig_grp = 'ModelSigs';
               create_fromblks(sig_dir , sig_grp);  
               path_sig_grp = [sig_dir, '/', sig_grp, '_from' ];
               new_sig_grp =  [get_param(path_sig_grp, 'Name'), ...
                   num2str(cnt_grp)];
               set_param(path_sig_grp , 'Name',  new_sig_grp);
               path_sig_grp = [sig_dir, '/', new_sig_grp];
           
               set_param(path_sig_grp, 'Position', pos);
        
               % 2) create busselector
               name_busselector = ['bus_selector', num2str(cnt_grp)];
               path_busselector = [sig_dir, '/', name_busselector ];
               create_busselector(sig_dir, name_busselector, 1);
               set_param(path_busselector, 'Position', pos1);

               % 3) connect to busselector     

               cnct_blks2bus(sig_dir, new_sig_grp, name_busselector)

               % 3+) operate handles on bus slector
               set_param(path_busselector, 'OutputSignals', sig_pool )

               % 4) create gw subsystem
               name_sig_gw = [sig_pool, '_gw'];
               path_sig_gw = [sig_dir, '/', name_sig_gw ];
               create_cnst_gw(sig_dir,  name_sig_gw)
               set_param(path_sig_gw, 'Position', pos2)
            
               % 5) connect busselector to gw subsystem
               cnnt_bus2blks(sig_dir, name_busselector , name_sig_gw)

               % 6) connect gw subsystem to bus creator
               if port_num > 0
                    cnct_blks2bus(sig_dir,name_sig_gw, bus_cnnt, ...
                        port_num, ['model_', sig_pool,]);
               end 
              
               cnt_grp = cnt_grp + 1;

         end


    end


end