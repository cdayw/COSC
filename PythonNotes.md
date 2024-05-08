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





























party = {'first':{'Gengar':'ghost'}}
print(party)
