function varargout =  uncnct_blks2bus(dir, names_blk)
%--------------------------------------------------------------------------
%------------------M-File Model Generation Block -------------------------------
%--------------------------------------------------------------------------
%
%Author:
%       Mingqi Shi, mingqis qti qm
%
%Created:
%       2023-08-26
%
%Last modified:
%       Mingqi Shi
%       2023-08-25
%
%Version:
%       0.3
%
%Description:
%       See Eample Run below and Demo document
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


%connect blocks to bus consts / subsgcystem with - out_port
   
%Example Run: uncnct_blks2bus(gcs,{'x', 'y', 'z', 'u', 'v', 'w'})
%dir = system;
%names_blk = {'a', 'b', 'c', 'd', 'e', 'f'};
%Example Run: [bus_cnnt, port_num ] = uncnct_blks2bus(gcs,{'x', 'y', 'z', 'u', 'v', 'w'})
% Varargout(1) name of destinaton block
%Varargout(2) which port connects to from source

if(ischar(names_blk ))
    names_blk = {names_blk };
end

idxs = zeros(length(names_blk), 1);
dst_names = cell(length(names_blk), 1);



for i = 1: length(names_blk)


    blk_i = names_blk{i};
    path_blk_i = strcat(dir, '/', blk_i);

    try
       h_input = get_param(path_blk_i,'LineHandles');

        h_dst = get_param(  h_input.Outport, 'DstBlockHandle');
        dst_name = get_param(h_dst, 'Name');
        input_names_dst = get_param(h_dst, 'InputSignalNames');
    
        match = cellfun(@(x) strcmp(x, blk_i), input_names_dst , ...
        'UniformOutput', 0);
    

        delete_line(h_input.Outport(1))

        dst_names{i} = dst_name;
        idxs(i) = find(cell2mat(match));

    catch
        disp([blk_i, ' not found'])
    end
  
end

varargout{1} = dst_names;
varargout{2} = idxs;

