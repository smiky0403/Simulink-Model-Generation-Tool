function cnnt_inport2blks(dir, name_port, names_blk)
%--------------------------------------------------------------------------
%------------------M-File Model Generation Block -------------------------------
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


%Example Run: cnnt_inport2blks('test_mdl/FD1_CAN_P702_GASD_MY21_DCV_V06','in_port',{'ABS_ESC', 'CMR_DSMC'})
%Example Run: cnnt_inport2blks(gcs,'in_port',{'a', 'b'}, 'Host_Model')
input = [name_port, '/1'];

for i = 1: length(names_blk)
    
    output = [names_blk{i}, '/1'];
    try
        add_line(dir, input, output)
    catch
        disp ([names_blk{i}, ' not connected'])
    end

end

end