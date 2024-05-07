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
