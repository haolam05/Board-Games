class HandInfo
    def ranks
        [:high_card, :one_pair, :two_pair, :three_of_a_kind, :straight, :flush, :full_house, :four_of_a_kind, :straight_flush]
    end

    def values_table
        { 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, "J" => 11, "Q" => 12, "K" => 13, "A" => 14 }
    end

    def suits_table
        { 'c' => 1, 'd' => 2, 'h' => 3, 's' => 4 }
    end
end