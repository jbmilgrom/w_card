@text = 
"XXXXXXXXXXXXX*X*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXXXXXX*XXXXXXXXXXXXXXXXXXXXXXXXXXXXX*XXX*XXXX*XX
XXXXXXXXXXXXXXXX*XXXXXXXX*XXXXXXXXXXXXXXXXXXXXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXX*XXXXXXXXXXXXX**XXX*XX*XX*XX*XXXXXXXXXXXXXXXXXX
XXXXXXXXXXX*XXXX*XXXXXXXX*XXXXXXXXXX*XXXXXX*XXXXXX
XXXXXXXX*XXXXXXXXXXXXX*XXXXX*XXXXX*X**XXXXXXXXXXXX
XXXXXXXXXXXX*XXXXXXXXXXXXXXXXXXXXXXXXXXXX*X*XXXXXX
XXXX*XXXXXXXX*XXXXXXX**XXXX**XXXXXXXXXXXXXXXXXXXXX
**XXXXXXXXXX*XXXXXX*XXXXXXXXXXX*XXXXXXXXXXXXXXXXX*
XXXXXXXXXXXXXXXXXX*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXXXX*XXXXXXXXXXXX*XXXXXXXXXX*XXXXXXXXXXXXXXXXXXX
*XXXXXXXXXXXXXXXXXXXX**XX***XX*XXXXXXXXXXXXX*XXXXX
XXXXXXXXXXX*XXX**XX*X*XXXX*XXX*X*XXX*XXXXX*XXXXXXX
XXXXXXXXXXXXX*XXXXXXXXXX*XXXXX*XXXXXXXXX*XXXXXXXXX
XXXXXXXXXXXXXXXXX*XXXXX*XXX*XXXX*XXXXXXXXX*XXXXXXX
XXXXXXXX*X*XXXXXXX*XXXXXXXXXXXXXXX*X*XXXX*XX*XXXXX
XXXXXXXXX*X*XXXXX*XXXXXX**XXXXXXXXXX*XX*XXXXXXX*XX
XXXXXXXXXXXXXXXX**XX*XX*XXXXXXXXXXXXXX*XXXXXXXXXXX
XXXXXXX**XXX*XXXXXXXXXXXXX*XXXXXXXXXXXXXX*XXXXXXXX
XXXX*XXX*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXXXXXXX*XXXXXXXXX**XXXXX*XXXXXXXXXX*XXXXXX*XXXXX
XXXXXX*XXX**XXXXXXXXXX*XX*XXX*XXXXXXXXXXXX*XXXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXX*XXXXXX*XX*XXXXXXX***XXXXXXXXXXXXXXXXXXXX*XXXX
XX**XXXXXXXXXXXXXXXX**X*XXXXX*XXXXXXXXX*XXXXXXXXXX
*X*XXXXXXXX**X*XXXXXXXXX*XXXXXXXXXXX*XXXXXXXXXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*XXXXXXX*XXXXXXXXXXXXX**XXXXXXX*XXXX*XXX*XXXXXXXXX
X*XXXXXXXXXXX*XXXXXX*XXXXXXX**X*XX*XXXXXXXXXXXXXX*
XXXXXXXXXXXXXXXXXX**XXXXXXXXXXX*XXXXXXXXX*XX*X*XXX
XXXXXXXXX*XXXXXXXXX*XXXXXXXXXXXXXX*XXXXXXXX*XX*X*X
XXXXXXXXXXXXXXXXXX*XXXX*XXX*XXXX*XXXXXXXXXXX*XXX*X
XXXXXXXXXXX*XXXXX*XXXXXX*XXX*XXXXXXXXXXXXXXXXXXXXX
X*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX**XXXXXXX
XXXXXXXXX*X*XXXX*XXXXXXXXXXXXXXXXXXXXXXXXX*X*XXXXX
XXX*XXXXXXXXXXXXX*XXXXXXXXXXX*XXXXXXXXXXXXXXXXXXXX
XXXXXXXXXX*XX*XXXX*XXXXXXXXXXXXX*XXXXX*X*XXXX*XXXX
X*XX*XXX*X*XXXXXXXXXXXXXXXXXXXX*XXXXXXXXXXXXXXXXXX
XXXXXXXXXX*XXXXXXXXXXXXXXXXXXXXXXXX*XXXXXX**XXXXXX
**XXXXXXXXXXX*XXXXXXXXXXXXX*XXXXXXXXXXXX*XXXXX*XXX
X*XXXXXXXXXXXXXXXXXXXXXXXXXXXX*XX**XXXXX*XXXXXXXXX
XXXXXXXXXXXXXX*XXX*XXXXXXXXX*XXXXXXXX**XXXXXXX*XXX
XXXXXXXXXX*XXXXXXXXXXXXXXX*X*XXXXXXXXXXXXXXXX*XXXX
XXXXXXXXXXX*XXXX*XXXXXXXXXXXX*XXXX*XXXXXXXXX*XXXXX
XXXXXXXXXXXXX*XXXXXXXXXXXXX*XXXX*XXXX*XXXXXXXXXXXX
XXXXXXXXXXX*XXXXX*XXXXXXXXXXXX*XXXXXXXXXXXX*XXXX*X
XXXXXXX*XXXXXXXXXXXXXXXX*XX*XXXXXXXX*XXXXXXXXXXXXX
XXXXXX*XXX*XXXXXXXXXXXXXXXXXXXXXXXXXX*XXXXXXX*XXXX
XXXXX*XXXXXXXX*XXXXX*X*XXXXXXXXXXXXX*XX*XXXXXXX**X"

####### STEP 1 #######
######################
# parse the text string above into an array of rows, themselves, each, an array of chars
def array_of_row_arrays(text)
  c = 0
  arr = []
  arr_of_arrys = []
  # add "\n" to last row of string to make symmetric with previous rows
  # creating an array every 51 chars, and push such array into container array
  text.split('').push('\n').each_with_index do |value, i| 
    c += 1
    arr << value
    if c == 51
      c = 0
      arr_of_arrys << arr
      arr = []
    end
  end
  return arr_of_arrys
end

####### STEP 2 #######
######################
# turn the array of rows into an array of columns
# so that the below methods (i.e. steps 3 & 4) can now be equally applicable to columns as rows
@array_of_column_arrays = []
def rows_to_columns(arr_of_row_arrays, row)
  arr_of_row_arrays.each do |array|
    @array_of_column_arrays[row] = [] unless @array_of_column_arrays[row]
    @array_of_column_arrays[row] << array.pop
  end
  # recursively call rows_to_columns until arr_of_row_arrays is empty
  # then return new array wrapper organized around @text's columns
  arr_of_row_arrays[0][0] ? rows_to_columns(arr_of_row_arrays, row + 1) : @array_of_column_arrays
end

####### STEP 3 #######
######################
# count the number of '*' that occur in a given row
# return an array of such numbers
def star_counter(arr_of_arrys)
  counter_arr = []
  arr_of_arrys.each do |array|
    num_of_stars = 0
    array.each do |value|
        num_of_stars += 1 if value == "*"
    end
    counter_arr << num_of_stars
  end
  return counter_arr
end

####### STEP 4 #######
######################
# given the amount of '*' in a given row/column, count the number of permutations/combinations that may occur
# and return the total amount
def total_card_combs(star_counter)
  c = 0
  star_counter.each { |num_of_stars| c += factrl(5) * cmbnation(num_of_stars) if num_of_stars > 4 }
  return c
end

# for a group with m members (where m >= 5), determine the number of combinations comprising 
# a subgroup of size (m - 5) pooled from the m members of the larger group
# in this problem, the group can be thought of as the 5 cards plus any potentially unused "*"s.
def cmbnation(m)
  factrl(m) / ( factrl(m - 5) * factrl(5) )
end

# for a set of 5 '*', the number of position of 5 stars can be found through  
# find factorial of num >= 0
def factrl(num)
  num > 0 ? num.downto(1).inject(:*) : 1
end

###### RESULTS #######
######################
puts "total combinations of card arrangements (rows): #{total_card_combs(star_counter(array_of_row_arrays(@text)))}"
# puts "total combinations for arrangements (rows): 84840"

puts "total combinations of card arrangements (columns): #{total_card_combs(star_counter(rows_to_columns(array_of_row_arrays(@text), 0)))}"
# "total combinations card arrangements (columns): 82320"

puts "total combinations of card arrangements (rows plus columns): #{total_card_combs(star_counter(@array_of_column_arrays)) +  total_card_combs(star_counter(array_of_row_arrays(@text)))}"
# "total combinations card arrangements (rows plus columns): 167160"

