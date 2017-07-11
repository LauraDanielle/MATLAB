function sorted = whichWand(struct, field)
    if any(strcmp(field, fieldnames(struct)))
        names = {struct.(field)};
        if strcmp(class(names{1}), 'double')
            names =  [names{:}];
        end
        [sorted ind] = sort(names);
        sorted = [];
        for i = 1:length(struct)
        sorted = [sorted struct(ind(i))];
        end
    else
        sorted = 'Invalid Field Name';
    end
end