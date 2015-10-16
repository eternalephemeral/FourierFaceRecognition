function B = diagTrav(A, iter)
%Traverses through array A in the following diagonal way
%1 2 4 7
%3 5 8
%6 9
%10
%up to 'iter' iterations and returns the values traversed
    B = [];
    n = min(size(A));
    count = 1;
    for slice = 0:2*n-2
        if (slice < n)
            z = 0;
        else
            z = slice - n + 1;
        end
        for j = z:slice-z
            B = [B, A(j+1, slice-j+1)];
            count = count + 1;
            if (count > iter)
                return;
            end
        end
    end

end

