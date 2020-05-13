#! /usr/bin/env bash

# AWS S3 Bucket Variables
echo -n "What is the AWS Access Key ID? "
read AWSKEYID
echo -n "Would you like to use $AWSKEYID? - Y or N: "
read AWSKEYIDANSWER
AWSKEYIDANSWER=`echo $AWSKEYIDANSWER | tr "[:lower:]" "[:upper:]"`
until [ $AWSKEYIDANSWER == 'Y' ]; do
    echo -n "What is the AWS Access Key ID? "
    read AWSKEYID
    echo -n "Would you like to use $AWSKEYID? - Y or N: "
    read AWSKEYIDANSWER
    AWSKEYIDANSWER=`echo $AWSKEYIDANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "AWS_ACCESS_KEY_ID Set"

echo -n "What is the AWS Secret Access Key ID? "
read AWSSECRETKEYID
echo -n "Would you like to use $AWSSECRETKEYID? - Y or N: "
read AWSSECRETKEYIDANSWER
AWSSECRETKEYIDANSWER=`echo $AWSSECRETKEYIDANSWER | tr "[:lower:]" "[:upper:]"`
until [ $AWSSECRETKEYIDANSWER == 'Y' ]; do
    echo -n "What is the AWS Secret Access Key ID? "
    read AWSSECRETKEYID
    echo -n "Would you like to use $AWSSECRETKEYID? - Y or N: "
    read AWSSECRETKEYIDANSWER
    AWSSECRETKEYIDANSWER=`echo $AWSSECRETKEYIDANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "AWS_SECRET_ACCESS_KEY Set"

echo -n "What is the AWS Default Region? "
read AWSREGION
echo -n "Would you like to use $AWSREGION? - Y or N: "
read AWSREGIONANSWER
AWSREGIONANSWER=`echo $AWSREGIONANSWER | tr "[:lower:]" "[:upper:]"`
until [ $AWSREGIONANSWER == 'Y' ]; do
    echo -n "What is the AWS Default Region? "
    read AWSREGION
    echo -n "Would you like to use $AWSREGION? - Y or N: "
    read AWSREGIONANSWER
    AWSREGIONANSWER=`echo $AWSREGIONANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "AWS_DEFAULT_REGION Set"

echo -n "What is the AWS Bucket? "
read AWSBUCKET
echo -n "Would you like to use $AWSBUCKET? - Y or N: "
read AWSBUCKETANSWER
AWSBUCKETANSWER=`echo $AWSBUCKETANSWER | tr "[:lower:]" "[:upper:]"`
until [ $AWSBUCKETANSWER == 'Y' ]; do
    echo -n "What is the AWS Bucket? "
    read AWSBUCKET
    echo -n "Would you like to use $AWSBUCKET? - Y or N: "
    read AWSBUCKETANSWER
    AWSBUCKETANSWER=`echo $AWSBUCKETANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "AWS_BUCKET Set"

echo -n "What is the AWS CF URL? "
read AWSCFURL
echo -n "Would you like to use \"$AWSCFURL\"? - Y or N: "
read AWSCFURLANSWER
AWSCFURLANSWER=`echo $AWSCFURLANSWER | tr "[:lower:]" "[:upper:]"`
until [ $AWSCFURLANSWER == 'Y' ]; do
    echo -n "What is the AWS CF URL? "
    read AWSCFURL
    echo -n "Would you like to use \"$AWSCFURL\"? - Y or N: "
    read AWSCFURLANSWER
    AWSCFURLANSWER=`echo $AWSCFURLANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "AWS_CF_URL Set"

echo -n "What is the MIX AWS CF URL? "
read AWSMIXCFURL
echo -n "Would you like to use \"$AWSMIXCFURL\"? - Y or N: "
read AWSMIXCFURLANSWER
AWSMIXCFURLANSWER=`echo $AWSMIXCFURLANSWER | tr "[:lower:]" "[:upper:]"`
until [ $AWSMIXCFURLANSWER == 'Y' ]; do
    echo -n "What is the MIX AWS CF URL? "
    read AWSMIXCFURL
    echo -n "Would you like to use \"$AWSMIXCFURL\"? - Y or N: "
    read AWSMIXCFURLANSWER
    AWSMIXCFURLANSWER=`echo $AWSMIXCFURLANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "MIX_AWS_CF_URL Set"
