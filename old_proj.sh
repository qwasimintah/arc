cd projet_asic
mkdir "$1"
cd "$1"
mkdir bench
mkdir confmodelsim
mkdir libs
mkdir srcvhd
cp ../Add1/confmodelsim/* confmodelsim/
cp ../Add1/srcvhd/* srcvhd/
cp ../Add1/bench/* bench/

