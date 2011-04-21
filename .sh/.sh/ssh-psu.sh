#! /bin/bash
#
# Script to connect to PSU's dev servers, so I don"t have to type the long domains in... or remember my password
#
#

# Declare array of possible server choices
server_array=( "turing" "uranus.dev" "uranus" "dev" );
argument="$1";

# If no arguments were passed
if [ "$#" -lt 1 ]
then
	echo -e "\nYou did not specify which server you'd like to connect to. Please choose from the following:\n";

	# Loop through array and echo out each possibility
	for i in "${server_array[@]}"
	do
		echo $i;
	done
	
	echo "";

	# Read in an argument
	read argument;
	
	echo "";
fi

# Correct the "alias" arguments
if [ "$argument" == "uranus" -o "$argument" == "dev" ]
then
	argument="uranus.dev";
fi

# Now that we have the argument (either you were prompted or you already typed it in)
if [ "$argument" == "turing" -o "$argument" == "uranus.dev" -o "$argument" == "uranus" -o "$argument" == "dev" ]
then
	ssh tnsuarez@"$argument".plymouth.edu
else
	echo "Argument is not valid.";
fi
