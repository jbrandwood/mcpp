#! /bin/sh
# script to set mcpp testsuite corresponding to the version of GCC 2 or 3
# ./set_test.sh ${CC} ${gcc_path} ${gcc_testsuite_dir} ${gcc_maj_ver} ${LN_S}

CC=$1
gcc_path=`expr $2 : "\(.*\)/${CC}"`
gcc_testsuite_dir=$3
gcc_maj_ver=$4
if test ${gcc_maj_ver} = 4; then
    gcc_maj_ver=3;
fi
LN_S=$5
cur_dir=`pwd`

echo "  cd ${gcc_testsuite_dir}/gcc.dg/cpp-test/test-t"
cd "${gcc_testsuite_dir}/gcc.dg/cpp-test/test-t"
for i in *_run.c
do
    rm -f $i
    echo "  ${LN_S} $i.gcc${gcc_maj_ver} $i"
    ${LN_S} $i.gcc${gcc_maj_ver} $i
done

if test ${CC} = gcc; then
    exit 0
fi

echo "  cd ${gcc_path}"
cd "${gcc_path}"
if test -f "gcc"; then
    echo "  mv gcc gcc.save"
    mv gcc gcc.save
fi
echo "  ${LN_S} ${CC} gcc"
${LN_S} ${CC} gcc
echo "  cd ${cur_dir}"
cd "${cur_dir}"
