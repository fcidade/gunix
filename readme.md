Done:
- pwd

Available:
- cat
- head
- tail
- ls
- cd (acho q é do shell)
- bg
- diff
- cmp
- cp
- less
- grep (e variantes)
- kill
- mv
- read
- ln (symlinks)
- echo (acho q é do shell)

https://en.wikipedia.org/wiki/List_of_Unix_commands

man ksh | col -b > ksh.txt




You can use these ANSI escape codes:

Black        0;30     Dark Gray     1;30
Red          0;31     Light Red     1;31
Green        0;32     Light Green   1;32
Brown/Orange 0;33     Yellow        1;33
Blue         0;34     Light Blue    1;34
Purple       0;35     Light Purple  1;35
Cyan         0;36     Light Cyan    1;36
Light Gray   0;37     White         1;37
And then use them like this in your script:

#    .---------- constant part!
#    vvvv vvvv-- the code from above
RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I ${RED}love${NC} Stack Overflow\n"
which prints love in red.

From @james-lim's comment, if you are using the echo command, be sure to use the -e flag to allow backslash escapes.

#    .---------- constant part!
#    vvvv vvvv-- the code from above
RED='\033[0;31m'
NC='\033[0m' # No Color
echo -e "I ${RED}love${NC} Stack Overflow"
Note: Don't add "\n" when using echo unless you want to add an additional empty line.

https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux