function [new_threshold]=set_threshold(old_threshold, direction)
    if (direction == '+')
        new_threshold = old_threshold + 0.1;
    elseif (direction == '-')
        new_threshold = oldthreshold - 0.1;
    end
end