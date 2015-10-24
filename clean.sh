#!/bin/bash

if [ $# -lt 2 ]; then
	echo Nope.
	echo "  Usage: $0 infile outfile"
	echo "  Also, I'm a disciple of the Steve; I want BSD sed."
	exit 1
fi

if [ ! -f $1 ]; then
	echo Hunh?
	echo "   Can't find $1. Remember, God hates spaces in file names."
	exit 2
fi

HTML=$1
WORKING=/tmp/outfile
OUT=$2

cp "$HTML" $WORKING
echo . reStructuring HTML
sed -i.bak -e 's/<\/*i>/\*/g' $WORKING
sed -i.bak -e 's/<\/*b>/\*/g' $WORKING
sed -i.bak -e 's/<br>/\
 \
 /g' $WORKING

# Eliminate leading white space
echo . eliminating vacuous statements
sed -i.bak -e 's/^[ ]*//g' $WORKING
sed -i.bak -n -e ":a" -e "$ s/ \n/ /gp;N;b a" $WORKING

echo . tidying loose cannons
sed -i.bak -e 's/<[^>]*>//g' $WORKING
sed -i.bak -e 's/^( *)//g' $WORKING
sed -i.bak -e '/^.*\*\*.*$/d' $WORKING
sed -i.bak -e '/^[0-9]+.*$/d' $WORKING
sed -i.bak -e '/^([0-9\ ].*$/d' $WORKING
sed -i.bak -e '/:$/d' $WORKING
sed -i.bak -e '/^*/d' $WORKING

# Hunt down specific mechanics
echo . ignoring things
sed -i.bak -e '/^No Effect!$/d' $WORKING
sed -i.bak -e '/^\*Effect:\*\r.*/d' $WORKING
sed -i.bak -e '/^No damage taken!$/d' $WORKING
sed -i.bak -e '/^(will become/d' $WORKING
sed -i.bak -e '/^All States &amp; hits cleared\.$/d' $WORKING
sed -i.bak -e '/^.*got a Hero Point/d' $WORKING
sed -i.bak -e '/^The total rolled/d' $WORKING
sed -i.bak -e '/^is \*[0-9]*\*.$/d' $WORKING
sed -i.bak -e '/^\*Tirion\* $/d' $WORKING
sed -i.bak -e '/^\*Jack \*$/d' $WORKING
sed -i.bak -e '/^rolls \*.*\*\.$/d' $WORKING
sed -i.bak -e '/^[0-9].*against/d' $WORKING
sed -i.bak -e '/^The attack targets/d' $WORKING
sed -i.bak -e '/^You.*are.*until you \*Recover\*./d' $WORKING
sed -i.bak -e '/^[0-9]* teammates assisted.*, rolling.*;/d' $WORKING

# MapTool glitch
echo . concealing sloppy coding
sed -i.bak -e '/^.* says, &quot;&quot;$/d' $WORKING

# Fix bold italics
echo . de-emphasizing emphasis
sed -i.bak -e 's/\*\*\*/\*\*/g' $WORKING

# Tirion hates fancy quotes but insists on accent marks
echo . placating Tirion
sed -i.bak -e 's/&quot;/"/g' $WORKING
sed -i.bak -e 's/&amp;/&/g' $WORKING
sed -i.bak -e "s/&#8217;/'/g" $WORKING
sed -i.bak -e "s/&#8220;/'/g" $WORKING
sed -i.bak -e "s/&#8221;/'/g" $WORKING
sed -i.bak -e "s/&#8211;/--/g" $WORKING

# Remove multiple blank lines
echo . deflating gasbag
sed -e 's/^\s+$//' $WORKING | cat -s > $OUT

echo . leaving crap for humans to do
