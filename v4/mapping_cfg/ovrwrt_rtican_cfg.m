function cell_output = ovrwrt_rtican_cfg(cell_file, strct_bus)
%--------------------------------------------------------------------------
%------------------M-File CAN Mapping Script Block --------------------------
%--------------------------------------------------------------------------
%
%Author:
%       Mingqi Shi, mshi15
%
%Created:
%       2019-08-21
%
%Last modified:
%       Mingqi Shi
%       2019-08-21
%
%Version:
%       0.3
%
%Description:
%       See Eample Run below and Demo document
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%Logic: Take Existing config file for RTICANMM, 
%Example  Run: new_texts = ovrwrt_rtican_cfg(texts, trgt_x);

%texts = readfile2cell ('test_FD_config.m');
%texts_NI=  readfile2cell ('NI_Final_Mapping.txt');

list_bus = iterateStruct(strct_bus);

list_choosen =  list_bus;
%list_choosen = filter_bus(list_bus);

tokens_MIL = cellfun(@(x) strsplit(x, '.'), list_choosen, 'UniformOutput', 0 ); % each cell length > 2
 
list_msg = cellfun(@(x) x{end - 1}, tokens_MIL, 'UniformOutput', 0);

list_sig = cellfun(@(x) x{end}, tokens_MIL, 'UniformOutput', 0);

cell_output = cell(size(cell_file));

for i = 1: size(cell_file , 1)
    
    expr = cell_file{i};
    
    if isempty(expr)
        continue
    end
        
    w1 = strsplit(expr, '=');
    %w1 = regexp(expr, '=', 'split');    
    if length( w1 ) < 2   % Not equation format
        cell_output{i} = expr;
        continue
    else
        expr_left = w1{1};
        w2 = strsplit(expr_left, '.');
        %w2 = regexp(expr_left, '.', 'split');   
        

        if length(w2) ~= 4          % not RTICANMM format, maybe 1st line
            cell_output{i} = expr;
            continue;      
        else               %correct format
            cur_msg = w2{2};
            cur_sig = w2{3};           
            % Logic, matching list bus ending with same: message.signal

            idx = find ( strcmp(list_msg, cur_msg) & ...
                    strcmp(list_sig, cur_sig), 1  )  ;
                
            if isempty(idx)          % other RTICANMM mapping for in MIL 
                cell_output{i} = expr;
                continue;                     
            else                     % RTICANMM mapping for in MIL       
                %Overwitting session
                path_choosen = list_choosen{idx(1)};
                expr_right = ['''', path_choosen, '''', ';'];
                new_expr = [expr_left, ' = ', expr_right];
                cell_output{i} = new_expr;
            end
            
        end
    end
       
    
end

end