function SW = GetSW(Sc,wavelength)
wl = wavelength;

% Normalize weights (if not already normalized)
if sum(Sc) ~= 1
    Sc = Sc/ sum(Sc);
end

% Calculate weighted average
SW = sum(Sc.*wl);

% Display the result
disp(['The weighted average is: ', num2str(SW)]);
end