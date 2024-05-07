# Python Notes 

chmod 777 script

## set enviroment - #!/usr/bin/env python3 

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
```
## .vimrc
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

## Split and Join -- creates a list (indicated by the parenthesis)
```
split

>>> 'user:passwd'.split(':')
['user', 'passwd']

join
>>> ':' .join(passwd)
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
