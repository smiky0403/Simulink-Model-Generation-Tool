function [names_blk, varargout] = get_subsystems(varargin)
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
%       2023-08-23
%
%Version:
%       0.3
%
%Description:
%       See Eample Run below and Demo document, get ystem of current
%       Subsystem, NOT include sub systems inside a subsystem if iput args < 2
%         or opt = 0
%       if opt = 1 as 2nd arg, get all sub models names
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Example Run: get_subsystems()
%Example Run: get_subsystems('test_mdl/adc') or  get_subsystems('gcs') 
%Example Run: get_subsystems('test_mdl/adc',1])


if(nargin == 0)
    dir = gcs;
elseif(nargin >= 1)
    dir = varargin{1};
end

names_all = get_param(dir, 'Blocks');
names_all = regexprep(names_all, '/', '//'); %Patch '/'

paths_all = strcat(dir, '/', names_all);

types_all = get_param(paths_all, 'BlockType');

paths_subsystems = paths_all(strcmp(types_all, 'SubSystem') );

names_blk = names_all(strcmp(types_all, 'SubSystem') );

names_blk = regexprep(names_blk, '//', '/');  %Patch '/'

varargout{1} = paths_subsystems;



if(nargin == 2 )
    
    opt = varargin{2};

    if(opt == 0)
        % Do Nothing, i.e. only check current layer
    elseif (opt == 1)
        % Recursive, i.e. check all sub-layer
        for i = 1: length(paths_subsystems)
            dir = paths_subsystems{i};
            [names_sub, paths_sub] = get_subsystems(dir, 1);
            names_blk = [names_blk; names_sub];
            varargout{1} = [varargout{1}; paths_sub ];
        end

    end 

end

end