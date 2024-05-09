# Python Notes 

## set enviroment  
#!/usr/bin/env python3 

## Functions
```
print() <<< .format (used together typically)
type()
.split()
.join()
.append()
```

create a variable - a = "Hello"

print() inside of script/vim

type to view "type" of data
```
DATA TYPES
str 
bool 
int 
float 
```

## creating lists/indexes/tuple

cosc = '503'

list(cosc)  --- lists are mutable ['5', '0', '3']

cosc[0]  - index positon 0

changing variable to a list - cosc = list(cosc)

## Creating a tupble and Slicing 
tuple('103') > ('1', '0', '3') identified by parenthesis are like list and cannot be changed

Slicing [-1] - gives last element in list / [-2] - gives second to last element

## Append
var.append('STRING')

## Vim Settings - .vimrc
```
vim .vimrc
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab
set number
filetype indent on 
set autoindent
```
## .format 
```
a = 'Hello,'
b = 'World!'
print('{} {}').format(a,b))

Hello, World!
```

PI = {:.2f}'.format(3.14159265359)
PI = 3.14'


## Split and Join -- creates a list (indicated by the parenthesis)
```
split

'user:passwd'.split(':')
['user', 'passwd']

join
':' .join(passwd)
'user:passswd:/bin/bash'
```

## Email Exercise
```
 #!/usr/bin/env python3 
  email = 'last@domain.com'
  print(('.'.join(email.split('@'))).split('.'))
```
OR
```
 #!/usr/bin/env python3
 
 email = 'last@domain.com'
 blank = []
 a = email.split('@')[0]
 b = (email.split('@')[1]).split('.')
blank.append(a)
blank.append(b[0])
blank.append(b[1]) 
print(blank)

  >>>>   ['last', 'domain', 'com']
```

#Example of List , Tuple Join
```
print(list('hello'))
world = list('hello')
print(world)
print(tuple(world))
print(''.join(world))
```

# User Input()
### Example 
```
usr = input('Who is that Pokemon?: \n')
print('You chose {}.'.format(usr))
```
### FizzBuzz Exercise - Functions and User Input
```
num = int(input('Enter a number:\n'))
if num % 5 == 0 and num % 3 == 0:
    print('fizzbuzz')
elif num % 3 == 0:
    print('fizz')
elif num % 5 == 0:
    print('buzz')
else:
    print(num)
```

## Comparison Operators -- 
```
num = 7
if 0 <= num <= 10:
 print(num)
```
## While Counting Loop
```
num = 0
while num < 10:
  print(num)
  num += 1
```
### While Loop -- Pass, Continue, Break
```
while True:
 usr = input('Type pass, continue, or break:\n').lower
 if usr == 'pass':
  pass
  print('This is pass')
 elif usr == 'continue':
  continue
  print('This is Continue')
 elif usr == 'break':
  break
  print('This is break')
 else:
  print('Invalid Option')
```

### While Loop -- Guess a number
```
def guess_number(n):
    pass
 
   while True:
        usernum = int(input('Guess a Number:\n'))
       if usernum > n: 
            print('Too High, guess again.')
        elif usernum < n:
            print('Too Low, guess again')
        else:              
            print('WIN')
            break
guess_number(23)
```
## FOR loops --- counting loop
```
num = [1,2,3,4,5]
for i in num:
 print(i)
```
## Nested FOR loop -- Deck 
```
def makedeck():
 deck = []
 suits = ['\u2660' , '\u2665' , '\u2666' , '\u2663']
 ranks = ['A',2,3,4,5,6,7,8,9,10,'J','Q','K']
 for suit in suits:
     for rank in ranks:
        deck.append('{}{}'.format(rank,suit))
 print(deck)
makedeck()

```
## Range 
```
range(10)
range(0,10)
list(range(10))
```
OUTPUT > [0,1,2,3,4,5,6,7,8,9]

## [Start:Stop:Step] -- Counting Backwards
```
ten = list(range(1,10))
ten[::-1]
```
OUTPUT > [10,9,8,7,6,5,4,3,2,1]
## ord / chr
```
ord('a')
OUTPUT = 97

chr(97)
OUTPUT = a
```
## Print Items in list 
```
for index in range(len(<LIST>)):
 print(<LIST>[index])
```
```
for index in range(len(<LIST>)):
 if index == 1"
 print(<LIST>[index])
```
list = [apple, banna, pear, peach, grape]
```
def function(x,y):
 for index in range(len(y)):
  if index == x:
   print(y[index])
function(4,list)
```
## *args -- do not use star when referencing args
```
def q1(*args):
 print(args)
 prints(type(args))
```
### adding with *args and using format
```
def q1(*args):
    sums = 0
    for i in args:
            sums += i
    print('{} added together is {}'.format(args,sums))
q1(1,2,3,4,5)

```
## FILE IO
```
with open("test.txt", 'r') as fp:
 pass

'w' write
'r' read

with open("test.txt", 'w') as fp:
fp.write('First line \n')
   lines = ['Second Line \n', 'Third line\n', 'Fourth line\n', 'Last line\n']
   fp.writelines(lines)
^WRITES

with open("test.txt") as infile:
 infile.read(5)
OUTPUT = 'First' << the first fives characters

with open("test.txt") as brock:
  brock.readlines()
OUTPUT  = ['First line \n', 'Second Line \n', 'Third line\n', 'Fourth line\n', 'Last line\n']
```

## Total number of characters in file and save to var
```
num = 0 
with open("travel_plans.txt") as fp:
    num = (len(fp.read()))
```
## Total number of words and assign to var
```
num_words = 0
with open("emotion_words.txt") as fp:
   
    num_words = fp.read()
    num_words = len(num_words.split())
```
## Total number of lines and assign to var
```
num_lines = 0 
with open("school_prompt.txt") as fp:
        num_lines = len(fp.readlines())
```
## Assigning First 30 Chars to var
```
beginning_chars = ""
with open("school_prompt.txt") as fp:
    beginning_chars = fp.read(30)
```
## Assign third word of every line to list 
```
three = []
with open("school_prompt.txt") as fp:
    for line in fp:
        three.append(line.split()[2])
```
## Assign first word of every line to list
```
emotions = []
with open("emotion_words.txt") as fp:
    for line in fp:
        emotions.append(line.split()[0])
```
## Reversing sentences 'ehT kciuq nworb xof spmuj revo eht yzal .god'
```
def reverse_words(text):
    words = text.split(" ")
    newWords = [word[::-1] for word in words]
    newSentence = " ".join(newWords)
    
    return newSentence
```
## Reversing words - 'elppA'
```
return string[::-1]
```
## Multiply/Double Integers in a list > [1,2,3]
```
def maps(array):
    result = []
    for i in array:
        result.append(i * 2)
    return result
```
OUTPUT > [2,4,6]

# PRACTICE v1

TLO: 112-SCRPY002, LSA 3,4
Given the floatstr, which is a comma separated string of
floats, return a list with each of the floats in the
argument as elements in the list.
```
  lst = []
  for i in floatstr.split(','):
    lst.append(float(i))
  return lst
```
TLO: 112-SCRPY006, LSA 3
TLO: 112-SCRPY007, LSA 4
Given the variable length argument list, return the average
of all the arguments as a float
```
      sums = 0
      count = 0
      for n in args:
          sums += n
          count += 1
      return float(sums) / count
      pass
```
TLO: 112-SCRPY004, LSA 3
Given a list (lst) and a number of items (n), return a new 
list containing the last n entries in lst.
```
      print(lst)
      mylst = lst[-n:]
      return mylst
      pass

```
TLO: 112-SCRPY004, LSA 1,2
TLO: 112-SCRPY006, LSA 3
Given an input string, return a list containing the ordinal numbers of 
each character in the string in the order found in the input string.
```
      mylist = []
      lst = list(strng)
      print(lst)
      for x in lst:
          mylist.append(ord(x))
      return mylist
      pass
```
TLO: 112-SCRPY002, LSA 1,3
TLO: 112-SCRPY004, LSA 2
Given an input string, return a tuple with each element in the tuple
containing a single word from the input string in order.
```
return tuple(strng.split())
```
TLO: 112-SCRPY007, LSA 2
Given a dictionary (catalog) whose keys are product names and values are product prices per unit and a list of tuples (order) of product names and quantities, compute and return the total value of the order.
```
total = 0
for i in order:
    total += catalog[i[0]]*i[1]
return total
```
TLO: 112-SCRPY005, LSA 1
Given a filename, open the file and return the length of the first line 
in the file excluding the line terminator.
```
with open(filename) as fp:
    return (len(fp.readline())-1)
```
TLO: 112-SCRPY003, LSA 1
TLO: 112-SCRPY004, LSA 1,2
TLO: 112-SCRPY005, LSA 1
Given a filename and a list, write each entry from the list to the file
on separate lines until a case-insensitive entry of "stop" is found in 
the file on separate lines.
```
 with open(filename, 'w') as fp:
         for item in lst:
             if item.upper() == 'STOP':
                 break
             else:
                 fp.write('{}\n'.format(item))
```
TLO: 112-SCRPY003, LSA 1
Given the military time in the argument miltime, return a string 
containing the greeting of the day.
```
     if miltime >= 301 and miltime < 1200:
         return "Good Morning"
     elif miltime >= 1200 and miltime < 1600:
         return "Good Afternoon"
     elif miltime >= 1600 and miltime < 2100:
         return "Good Evening"
     else:
         return "Good Night"
```
TLO: 112-SCRPY003, LSA 1
TLO: 112-SCRPY004, LSA 1
Given the argument numlist as a list of numbers, return True if all 
numbers in the list are NOT negative. If any numbers in the list are
negative, return False.
```
    for i in numlist:
         if i < 0:
             return False
         else:
             return True
```
# PRACTICE v2
Given a string of multiple words separated by single spaces,
return a new string with the sentence reversed. The words
themselves should remain as they are.
```
my = sentence.split(' ') 
almost = my[::-1] 
return ' '.join(almost))
```
Given a positive integer, return its string representation with
commas seperating groups of 3 digits. For example, given 65535
the returned string should be '65,535'.
```
if n > 0:
    return"{:,}".format(n)
```
Given two lists of integers, return a sorted list that contains all integers from both lists in descending order. For example, given [3,4,9] and [8,1,5] the returned list should be [9,8,5,4,3,1]. The returned list may contain duplicates. ''' pass
```
return sorted(lst0+lst1, reverse=True)
```
