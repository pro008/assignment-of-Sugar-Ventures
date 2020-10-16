# ConvertPhoneDigit and LargestProfitPlotSale

The rails project created as a gem and use pure ruby to program

## Installation

Bundle Install


And then execute to run first task:

    $ ruby lib/convert_phone_digit.rb 

Second task:

    $ ruby lib/profitability_plots.sale.r

## First Task

In the first task, it is easier to use the "product" method of Array. However, to prove that I am using my logic to put in the code, I decided to code in manually.

## Second Task

In the second task, I try my best to improve the performance of the application. 

### Logic explain:

```ruby
range = "0 -10 0 1 -1 -2 -3 -4 -5 100 -2 1 -10 5 6 -1 -2 5 0 5"
```

#### Step 1 group by type, as a result of function cluster_profit:

```ruby
step1 =  [{:range=>[0, 0], :value=>0},
{:range=>[1, 2], :value=>-10}, ..., 
{:range=>[17, 17], :value=>5},
{:range=>[18, 18], :value=>0}, 
{:range=>[19, 19], :value=>5}]
```

#### Step 2 Merge continious profit in function merge_continious_prof_type:

```ruby
step2 =  [{:range=>[3, 3], :value=>1},
{:range=>[4, 8], :value=>-15}, ...,
{:range=>[17, 19], :value=>10}]
# Profit A, Profit B, Loss C = Profit {range from A to B}, Loss C
# make Profit, Loss, Profit, Loss alernating
```
#### Step 3 Merge continious profit in function merge_continious_prof_type:

```ruby
# merge 2 profit if loss is less than those two
```
#### Step 4 Loop find the largest profit
```ruby
# index_begin_with index_end sum
```