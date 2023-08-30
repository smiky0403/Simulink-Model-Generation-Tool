function valid = has_subsystem(dir, varargin)
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


% Example Run: valid = has_subsystem(gcs, {'a', 'b', 'c', 'd', 'd0', 'd1', 'd2', 'u', 'v', 'e'})

if isempty(varargin)
    name_blks = get_param(dir, 'Blocks');
else
    if ischar(varargin{1})  
        name_blks = {varargin{1}};  %To be improve for tokens such as 'a, b, c'
    else  %cell format, by default
        name_blks = varargin{1};
    end
end

exist_blks = get_param(dir, 'Blocks');
name_blks_dbl = regexprep(name_blks, '/', '//'); %Patch for '/'
path_blks = strcat(dir, '/', name_blks_dbl);
valid = false(length(path_blks), 1);

for i = 1: length(name_blks)
    
    
    valid_exist = ismember(name_blks{i}, exist_blks);
    if ~valid_exist
        disp([ '''', name_blks{i}, '''', ' does not exist in current directory' ] )
        continue
    end
    
    type_blk = get_param(path_blks{i}, 'BlockType');
    
   if strcmp(type_blk, 'SubSystem')   
        sub_blks = get_param(path_blks{i}, 'Blocks');
        sub_blks_dbl = regexprep(sub_blks, '/', '//');
        path_sub_blks = strcat(path_blks{i}, '/', sub_blks_dbl);
        type_sub_blks = get_param(path_sub_blks, 'BlockType');
        
        if any( strcmp(type_sub_blks, 'SubSystem')) 
             valid(i) = true;
        else
            continue
        end
  
    else
         continue   
    end
   
end



end