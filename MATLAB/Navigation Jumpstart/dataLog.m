function logData = dataLog(n)

    infofile = strcat('INF', n, '.TXT');
    datafile = strcat('LOG', n, '.BIN');
    
    if ~isfile(infofile) || ~isfile(datafile)
        error('File %s or %s not found.', infofile, datafile);
    end

    dataSizes.('float') = 4;
    dataSizes.('ulong') = 4;
    dataSizes.('int') = 4;
    dataSizes.('int32') = 4;
    dataSizes.('uint8') = 1;
    dataSizes.('uint16') = 2;
    dataSizes.('char') = 1;
    dataSizes.('bool') = 1;

    fileID = fopen(infofile);
    items = textscan(fileID,'%s','Delimiter',',','EndOfLine','\r\n');
    fclose(fileID);
    
    [ncols,~] = size(items{1});
    ncols = ncols/2;
    varNames = items{1}(1:ncols)';
    varTypes = items{1}(ncols+1:end)';
    varLengths = zeros(size(varTypes));
    
    colLength = 256; 

    
    for i = 1:numel(varTypes)
        if isfield(dataSizes, varTypes{i})
            varLengths(i) = dataSizes.(varTypes{i});
        else
            warning('Unknown data type: %s', varTypes{i});
            varLengths(i) = 0;
        end
    end

    fid = fopen(datafile,'rb');
    
    logData = struct();
    
    for i=1:numel(varTypes)
        fseek(fid, sum(varLengths(1:i-1)), 'bof');
        dataCol = fread(fid, Inf, ['*' varTypes{i}], colLength-varLengths(i));
        logData.(varNames{i}) = dataCol;
    end
    
    fclose(fid);
end