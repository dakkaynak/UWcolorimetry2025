function testPatch = visualizeColor(RGB,M)

if nargin<2
    M = 500;
end

testPatch = zeros(M,M,3);
rows = 1;
cols = 1;

for j = 1:3
    testPatch(1 + (rows-1)*M:M*rows,1+(cols-1)*M:M*cols,j) = RGB(j);
end