function texts = readfile2cell(file_name)
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


% Example: file_name = 'test_FD_config.m';
% Example Run: texts = readfile2cell ('test_FD_config.m');
fid=fopen(file_name);

%n = 15000;  % give large enough number - # of lines
n = linecount(fid);

fclose(fid);

fid=fopen(file_name);

texts = cell(n, 1);
i = 1;
    while i < n
     tline = fgetl(fid);
    if ~ischar(tline), break, end
         %disp(tline)
        texts{i} = tline;
    i = i + 1;
    end

fclose(fid);


function n = linecount(fid)
n = 0;
tline = fgetl(fid);
while ischar(tline)
  tline = fgetl(fid);
  n = n+1;
end
