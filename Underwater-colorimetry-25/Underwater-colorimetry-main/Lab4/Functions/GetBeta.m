function Beta = GetBeta(I1,I2,z1,z2)

dz = abs(z2 - z1);

if z2 > z1
    Beta = abs((1/dz)*log(I1/I2));
else 
    Beta = abs((1/dz)*log(I2/I1));
end