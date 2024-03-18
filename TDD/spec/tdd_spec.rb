require 'tdd'

describe '#uniq' do
    let(:array) { [1, 2, 1, 3, 3, 4, 4, 9, 9, 4, 4] }

    it 'only takes an array as a parameter' do
        expect { uniq(6) }.to raise_error ArgumentError
    end

    it 'removes diplicates, and return arr in the order that they first appeared' do
        expect(uniq(array)).to eq [1, 2, 3, 4, 9]
    end

    it 'does not change original array' do
        expect { uniq(array) }.to_not change { array }
    end
end

describe '#two_sum' do
    it 'only takes an array as a parameter' do
        expect { two_sum(6) }.to raise_error ArgumentError
    end

    it 'finds all pairs of distinct positions that their values sum to zero and sorts all pairs from small to big' do
        expect(two_sum([-1, 1, -1, -2, 1])).to eq [[0, 1], [0, 4], [1, 2], [2, 4]]
    end         

    it 'does not add 0 at the same index' do
        expect(two_sum([0, 1, 2])).to be_empty
    end

    it 'correctly add 0 at different indexes' do
        expect(two_sum([1, 0, 0])).to eq [[1, 2]]
    end
end

describe '#my_transpose' do
    it 'only takes an array as a parameter' do
        expect { my_transpose(6) }.to raise_error ArgumentError
    end

    it 'converts bw the row-oriented & column-oriented representations' do
        expect(my_transpose([[0, 1, 2], [3, 4, 5], [6, 7, 8]])).to eq [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
    end
end

describe '#stock_picker' do
    it 'only takes an array as a parameter' do
        expect { stock_picker(6) }.to raise_error ArgumentError
    end

    it 'outputs the most profitable pair of days' do
        expect(stock_picker([9, 2, 3, 8])).to eq [1, 3]
    end

    it 'sold_date has to be after its bought_day' do
        expect(stock_picker([1, 0, 1])).to eq [1, 2]
    end

    it 'does not trade if the trade is not profitable' do
        expect(stock_picker([3, 2, 1, 1])).to be_nil
    end
end

describe HanoiTowerGame do
    subject(:game) { HanoiTowerGame.new }

    describe '#initialize' do
        it 'uses 2D array to create 3 towers, in which a subArr is a tower' do
            expect(game.towers).to eq [[3, 2, 1], [], []]
        end
    end

    describe '#move' do
        it 'does not move to the same tower it is standing' do
            expect { game.move(0, 0) }.to raise_error HaveNotMovedError
        end

        it 'does not move from empty stack' do
            expect { game.move(1, 2) }.to raise_error EmptyStackError
        end

        it 'does not move bigger disc onto smaller disc' do
            game.move(0, 1)
            expect { game.move(0, 1) }.to raise_error BigToSmallStackError
        end 

        it 'can move to a blank tower' do
            expect { game.move(0, 1) }.to_not raise_error
            expect(game.towers).to eq [[3, 2], [1], []]
        end

        it 'can move smaller disc onto bigger disc' do
            game.move(0, 1)
            game.move(0, 2)
            expect { game.move(1, 2) }.to_not raise_error
            expect(game.towers).to eq [[3], [], [2, 1]]
        end
    end

    describe '#won?' do
        it 'is not won at start' do
            expect(game).to_not be_won
        end

        it 'is won when all discs are moved to tower 2' do
            game.move(0, 1)
            game.move(0, 2)
            game.move(1, 2)
            game.move(0, 1)
            game.move(2, 0)
            game.move(2, 1)
            game.move(0, 1)
            expect(game).to be_won
        end

        it 'is won when all discs are moved to tower 3' do
            game.move(0, 2)
            game.move(0, 1)
            game.move(2, 1)
            game.move(0, 2)
            game.move(1, 0)
            game.move(1, 2)
            game.move(0, 2)           
            expect(game).to be_won
        end
    end
end