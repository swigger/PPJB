#!/bin/bash
SRCIPD=`pwd`/temp
SRCNAME1=$(echo $SRCIPD/Payload/*.app)
SRCNAME2=${SRCNAME1%.app}
SRCNAME=${SRCNAME2##*/}

echo aaaa $SRCNAME


if [ "$OBJROOT" = "" ] ; then
	echo Run in xcode. >&2
	exit 0
fi

cd $OBJROOT
cd ../Products/Debug-iphoneos

rm -fr *.dSYM

NAME1=$(echo *.app)
NAME=${NAME1%.app}

echo $NAME

cd $NAME.app

rm -fr _CodeSignature
rm -fr *.mobileprovision
# rm -fr PkgInfo

for i in $SRCIPD/Payload/$SRCNAME.app/* ; do
	case ${i##*/} in 
		*.mobileprovision)
			;;
		_CodeSignature)
			;;
		Info.plist)
			;;
		$SRCNAME)
			cp $i $NAME
			;;
		*)
			rm -fr ${i##*/}
			cp -R $i .
			;;
	esac
done
