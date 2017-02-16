#!/bin/bash
SRCIPD=`pwd`/temp
SRCNAME1=$(echo $SRCIPD/Payload/*.app)
SRCNAME2=${SRCNAME1%.app}
SRCNAME=${SRCNAME2##*/}

if [ "$OBJROOT" = "" ] ; then
	echo Run in xcode. >&2
	exit 0
fi

echo source name is $SRCNAME
cd $OBJROOT

if [ ! -e ../Products/Debug-iphoneos ] ; then
	echo 'build again ...'
	exit 0
fi

cd ../Products/Debug-iphoneos

rm -fr *.dSYM

NAME1=$(echo *.app)
NAME=${NAME1%.app}

echo dest name is $NAME

cd $NAME.app
DESTP=`pwd`

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
			plcp $i Info.plist CFBundleIcons CFBundleIcons~ipad
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

if true ; then
	cp $SRCNAME1/Info.plist /tmp/xipa_src.plist
	cp $DESTP/Info.plist /tmp/xipa_dst.plist
	plutil -convert xml1 /tmp/xipa_src.plist
	plutil -convert xml1 /tmp/xipa_dst.plist
	echo bcomp /tmp/xipa_src.plist /tmp/xipa_dst.plist
fi
