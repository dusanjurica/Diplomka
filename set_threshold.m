function [new_threshold]=set_threshold(old_threshold, direction)

    switch direction
        case '+'
            new_threshold = old_threshold + 0.1;
        case '-'
            new_threshold = old_threshold - 0.1;
        case '++'
            new_threshold = old_threshold + 0.5;
        case '--'
            new_threshold = old_threshold - 0.5;
        otherwise
            new_threshold = old_threshold;
    end
    
end