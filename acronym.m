function out = acronym(phrase)
    out = '';
    while ~isempty(phrase)
        [word phrase] = strtok(phrase);
        if word(1) >= 'A' & word(1) <= 'Z';
            out = [out word(1)];
        end
       
    end

end
