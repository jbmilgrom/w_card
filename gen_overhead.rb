$generation =[9, 10, 21, 20, 7, 11, 4, 15, 7, 7, 14, 5, 20, 6, 29, 8, 11, 19, 18, 22, 29, 14, 27, 17, 6, 22, 12, 18, 18, 30]
$overhead =[21, 16, 19, 26, 26, 7, 1, 8, 17, 14, 15, 25, 20, 3, 24, 5, 28, 9, 2, 14, 9, 25, 15, 13, 15, 9, 6, 20, 27, 22]

# for larger groups of cards, initial generation costs play no meaningful role 
# in any max-min calculation
# so, pairing $gen and $over values in wrapper array
# sorting wrapper array by OVERHEAD values
def sorted_container_array(a1, a2)
  b =[] 
  a1.each_with_index do |v, i|
    b << [v, a2[i]]
  end
  return b.sort #this is the crux of the solution
end

# because the wrapper array as been sorted in order of increasing overhead costs,
# max cards can be determined by linearly increasing number of cards and breaking
# only once the set budget has been exceeded
def max_cards(budget, total_cards)
  max_cards = 0
  for num_of_cards in (1..total_cards)
    break if total_cost(sorted_container_array($overhead, $generation), num_of_cards) > budget
    max_cards = num_of_cards
  end
  return max_cards
end

# total cost of a 'num_cards' number of cards for the sorted container array,
# ordered by overhead cost
def total_cost(sorted_container_array, num_cards)
  total_cost = 0
  sorted_container_array[0..(num_cards-1)].each do |value|
    total_cost += cost_of_card(value[1], value[0], num_cards)
  end
  return total_cost
end

# cost of a card in a set of cards of size 'num_cards', given the parameters of the problem
def cost_of_card(gen, overhead, num_cards)
  gen + overhead * (num_cards-1)
end

###### RESULTS #######
######################
puts "Max Number of cards for a budget of 2912: #{max_cards(2912, 30)}"

