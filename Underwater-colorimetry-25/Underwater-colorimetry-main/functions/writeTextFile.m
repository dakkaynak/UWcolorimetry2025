% writeTextFile saves plain text to a new file/overwrites existing file.
%
% Status = writeTextFile(saveFolder,fileName,writeText) saves the writeText
% into a text file to be saved in the saveFolder, with the fileName. Note
% that extension should not be specified as .txt is added.
%
% Status is a struct containing human readable information about the result of the
% write.
%
% Derya Akkaynak 2019 | deryaa@alum.mit.edu
function Status = writeTextFile(saveFolder,fileName,writeText)

writePath = fullfile(saveFolder,[fileName,'.txt']);
fileID = fopen(writePath,'w');
fprintf(fileID,'%d\n', writeText);
status = fclose(fileID);

if status == 0 % write succesfull
    Status.saveSuccessful = 'yes';
else
    Status.saveSuccessful = 'no';
end