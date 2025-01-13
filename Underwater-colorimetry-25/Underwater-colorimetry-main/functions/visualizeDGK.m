function mcc = visualizeDGK(RGB)

% RGB is expected to be a matrix of 18 x 3.
% The input colors are expected to be in the right (typical) order for a
% Macbeth ColorChecker.

for i = 1:18
    imgs{i} = visualizeColor(RGB(i,:),100);
end

mcc = imtile(imgs,'GridSize', [3 6]);