#!/bin/bash
#
# Copyright (C) 2019-2022 crDroid Android Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#$1=TARGET_DEVICE, $2=PRODUCT_OUT, $3=FILE_NAME $4=CHERISH_BASE_VERSION
existingOTAjson=../vendor/miku/ota/wayne.json
output=$2/updates.json

#/home/linuxlite/aosp/out/target/product/wayne/EternityOS-v2.2-Flexible-wayne-13.0-20221114-1722-UNOFFICIAL.zip.sha256sum

#cleanup old file
if [ -f $output ]; then
	rm $output
fi

	filename=$(find "$3" | cut -d "/" -f8)
	BUILD_DATE=$(echo $filename | cut -d "-" -f6)
	type=$(echo $filename | cut -d "-" -f8)
	type=$(echo $type | cut -d "." -f1)
	type=$(echo $type | tr "A-Z" "a-z")
	version=$(echo $filename | cut -d "-" -f2)
	device=$(echo $filename | cut -d "-" -f4)
	url="https://sourceforge.net/projects/wayney/files/"$filename"/download"
	buildprop=$2/system/build.prop
	linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
	timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
	sha256=`sha256sum "$3" | cut -d' ' -f1`
	id=`md5sum "$3" | cut -d' ' -f1`
	size=`stat -c "%s" "$3"`
	BUILD_YEAR=${BUILD_DATE:0:4}
	BUILD_MONTH=${BUILD_DATE:4:2}
	BUILD_DAY=${BUILD_DATE:6:2}

	echo '{
  "response": [
  {
    "datetime": '$timestamp',
    "filename": "'$filename'",
    "id": "'$id'",
    "romtype": "'$type'",
    "size": '$size',
    "url": "'$url'",
    "version": "'$version'"
  }
 ]
}
' >> $output

        echo "JSON file data for OTA support:"

cat $output
echo ""
