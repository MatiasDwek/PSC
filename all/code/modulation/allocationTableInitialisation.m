function allocation_table = allocationTableInitialisation()
    allocation_table = ones(1, 255) * 8;

    allocation_table(1 : 63) = 10;
    allocation_table(64) = 10;
    allocation_table(65 : 127) = 9;
    allocation_table(128) = 8;
    allocation_table(129 : 191) = 7;
    allocation_table(192) = 7;
    allocation_table(193 : 223) = 7;
    allocation_table(224) = 5;
    allocation_table(225 : 240) = 5;
    allocation_table(241 : 248) = 5;
    allocation_table(249 : 255) = 5;
end