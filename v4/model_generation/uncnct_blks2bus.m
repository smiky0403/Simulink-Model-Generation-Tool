function uncnct_blks2bus(dir, names_blk)
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

if(ischar(names_blk ))
    names_blk = {names_blk };
end


for i = 1: length(names_blk)


    blk_i = names_blk{i};
    path_blk_i = strcat(dir, '/', blk_i);

    h_input = get_param(path_blk_i,'LineHandles');
    delete_line(h_input.Outport(1))


end
        

