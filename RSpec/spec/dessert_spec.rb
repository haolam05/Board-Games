require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", titleize: "Chef Hao the Great Baker") }
  let(:dessert) { Dessert.new("ice cream", 9, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq "ice cream"    #or: .to eq("ice cream")
    end                                         #() is optional

    it "sets a quantity" do
      expect(dessert.quantity).to eq 9
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty   #or: to eq []
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("ice cream","not_an_integer", chef) }.to raise_error ArgumentError
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(dessert.ingredients).to_not include "sugar"
      dessert.add_ingredient("sugar")
      expect(dessert.ingredients).to include "sugar"
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["ice", "milk", "vanilla", "flour", "eggs", "salt", "beans"]
      ingredients.each { |ingredient| dessert.add_ingredient(ingredient) }
      dessert.mix!
      expect(ingredients).to match_array(dessert.ingredients)
      expect(ingredients).to_not eq(dessert.ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(4)
      expect(dessert.quantity).to eq 5
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(10) }.to raise_error "not enough left!"
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(dessert.serve).to eq "Chef Hao the Great Baker has made 9 ice creams!"
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
