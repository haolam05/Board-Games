def my_reject(arr, &blk)
    arr.select { |el| !blk[el] }
end

def my_one?(arr, &blk)
    arr.count { |el| blk[el] } == 1
end

def hash_select(hash, &blk)
    hash.reject { |k, v| !blk[k, v] }
end

def xor_select(arr, prc1, prc2)
    arr.select { |el| (prc1[el] || prc2[el]) && !(prc1[el] && prc2[el]) }
end

def proc_count(val, arr)
    arr.count { |prc| prc[val] }
end
