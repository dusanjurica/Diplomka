function [new_threshold]=set_threshold(old_threshold, step, direction)

    switch direction
        case '+'
            new_threshold = old_threshold + step;
        case '-'
            new_threshold = old_threshold - step;
            
        otherwise
            new_threshold = old_threshold;
    end
    
end