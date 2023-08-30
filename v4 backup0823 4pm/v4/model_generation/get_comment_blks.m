 function [names_blk, idx_comment] = get_comment_blks(dir)
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

 
 %Example Run: names_blk = get_comment_blks(gcs)
names_all = get_param(dir, 'Blocks');
names_all = regexprep(names_all, '/', '//'); %Patch '/'

paths_all = strcat(dir, '/', names_all);


str_comment_status = get_param(paths_all, 'commented');
idx_comment = strcmp(str_comment_status, 'on');
names_blk = names_all(idx_comment);
names_blk = regexprep(names_blk, '//', '/');  %Patch '/'

end