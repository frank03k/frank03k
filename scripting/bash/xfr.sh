#!/bin/bash -eu

### INITIALIZE
SSHOPTS=
declare -a PCOMPS=( "pigz" "pxz" "pbzip2" )

### FUNCTIONS
synopsis () {
cat <<EOF

Synosis:

	$0 [options] \\
		-s|--src-dir  /path/to/src \\
		-u|--trg-user username \\
		-H|--trg-host IP|DNS \\
		-t|--trg-dir  /path/to/dest \\

EOF
}

usage () {
cat <<EOF
$0 is a bash script to copy a directory with max. possible speed
via network to another host. Rsync and ssh do not compress stream
in parallel.

Where options are:
	[-h|--help]	Display this page
	 -H|--trg-host	Target host (IP/DNS) to pass to ssh
	[-o|--ssh-opts]	Options to pass to ssh
	 -t|--trg-dir	Directory on target host
	 -s|--src-dir	Directory on source host
	 -u|--trg-user	User to pass to ssh

Parameters enclosed in
	[] are optional
	others are mandatory

EOF
}

### GET CLI PARAMETERS
# Note that we use `"$@"' to let each command-line parameter expand to a
# separate word. The quotes around `$@' are essential!
# We need TEMP as the `eval set --' would nuke the return value of getopt.
TEMP=$(getopt	-o hH:s:t:u: \
		--long help,trg-dir:,trg-host:,src-dir:,trg-user: \
		-n "$0" -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

while true ; do
    case "$1" in
        #-a|--a-long) echo "Option a" ; shift ;;
	-h|--help)	synopsis; usage; exit 0	;;
        -H|--trg-host)	THOST="$2";	shift 2 ;;
        -o|--ssh-opts)	SSHOPTS="$2";	shift 2 ;;
        -s|--src-dir)	SDIR="$2";	shift 2 ;;
        -t|--trg-dir)	TDIR="$2";	shift 2 ;;
	-u|--trg-user)	TUSER="$2";	shift 2 ;;
        #-c|--c-long)
        #    # c has an optional argument. As we are in quoted mode,
        #    # an empty parameter will be generated if its optional
        #    # argument is not found.
        #    case "$2" in
        #        "") echo "Option c, no argument"; shift 2 ;;
        #        *)  echo "Option c, argument \`$2'" ; shift 2 ;;
        #    esac ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

### SANITIZE INPUT
set +u
if [ -z "$SDIR" ]; then
	echo -e 'Error: Missing argument "-s|--src-dir"\nExiting…';
	synopsis
	exit 2
elif [ -z "$TUSER" ]; then
	echo -e 'Error: Missing argument "-u|--trg-user"\nExiting…';
	synopsis
	exit 2
elif [ -z "$THOST" ]; then
	echo -e 'Error: Missing argument "-h|--trg-host"\nExiting…';
	synopsis
	exit 2
elif [ -z "$TDIR" ]; then
	echo -e 'Error: Missing argument "-t|--trg-dir"\nExiting…';
	synopsis
	exit 2
fi
set -u

### CHECK FOR PARALLEL COMPRESSORS
for PCOMP in "${PCOMPS[@]}" "gzip"; do
	which "$PCOMP" 2>&1 >/dev/null
	[ "$?" -eq  0 ] && break
done

if [ "$PCOMP" = "gzip" ]; then
	cat <<-EOF
		Warning: No parallel compressor could be found.
		Please install on of "${PCOMPS[@]}".
		Transfer will be in efficient.

	EOF
fi

### GET CONFORMATION
cat <<-EOF
	Please double check the parameters:
	SOURCE-DIR:	"$SDIR"
	TARGET-USER:	"$TUSER"
	TARGET-HOST:	"$TDIR"
	TARGET-DIR:	"$THOST"
	SSH-OPTS:	"$SSHOPTS"
	COMPRESSOR:	"$PCOMP"
EOF

read -p "Ready or not [y/N]: " READY
if [[ "$READY" =~ [yY]([eE][sS])? ]]; then
	echo "Here we go!"
else
	echo "You can't hide. Exiting…"
	exit 0
fi

### MAIN
SDIR_PARENT="$SDIR/.."
pushd "$SDIR_PARENT"
SDIR_BASE="$(basename $SDIR)"


tar -cvpf - "$SDIR_BASE" \
	|$PCOMP -c \
	|ssh $SSHOPTS "$TUSER"@"$THOST" \
		"pigz -dc \
		|tar -xf - -C \"$TDIR\""
RETURN="$?"
echo
if [ "$RETURN" -eq 0 ]; then
	echo "TRANSFER SUCCESSFUL."
else
	echo "TRANSFER FAILED."
	exit "$RETURN"
fi
echo
