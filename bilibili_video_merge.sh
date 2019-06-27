#!/usr/bin/env bash
# @Filename: bilibili_video_merge.sh
# @Author:	wjsaya(http://www.wjsaya.top) 
# @Date:	2019-06-25 10:18:36 
# @Last Modified by:	wjsaya(http://www.wjsaya.top) 
# @Last Modified time:	2019-06-27 23:19:48 
 

function do_merge() {
    # do_merge args1
    # args1为想要合并的视频合集的绝对路径
    counter=0
    MERGE_DIR=$1
    
    if [ ! -d $MERGE_DIR ]
    then
        echo "指定目录：[$MERGE_DIR]不存在，请检查"
        return -1
    fi
        
    for sub_dir in `ls $MERGE_DIR | sort -n`
    # 遍历目录，获取每个分p的绝对路径
    do # 进入av编号目录
        full_sub_dir=$(pwd)/$MERGE_DIR/$sub_dir
        # FULL_MERGE_FILENAME=get_videoname $full_sub_dir

        # 1，从json获取视频合集名（av_title），以及单个分p文件名(av_part)
        av_title=`cat $full_sub_dir/entry.json | awk -F',' '{print $4}' | sed s@\"@@g  | cut -d: -f2 | sed s@\ @_@g`
        av_part=`cat $full_sub_dir/entry.json | awk -F',' '{print $19}' | sed s@\"@@g  | cut -d: -f2 | sed s@\ @_@g`
        echo "开始合并 "$av_title/$av_part.blv

        if [ ! -d $ROOT_PATH/$av_title ]
        then
            mkdir -p $ROOT_PATH/$av_title
        fi

        for single_file in `ls $full_sub_dir/lua.flv.bili2api.80 | grep blv$ | sort`
        do # 遍历单个视频目录，合并分p
            # 2，获取每个分p的blv文件
            # 3，合并blv文件
            cat $full_sub_dir/lua.flv.bili2api.80/$single_file >> $ROOT_PATH/$av_title/$av_part.blv
        done
        let counter+=1
        # ffmpeg -i "$single_file.blv" -vcodec copy -acodec copy "$single_file.mp4"
    done
        echo "#####$av_title全部转换完毕，共$counter个分p#####" && sleep 5
}


ROOT_PATH=$(pwd)/merged
# 合并后存放目录

echo -e "1:合并单个合集\n2:合并当前目录下所有合集\n"
read -p "请选择：" SW
if [ "1" == $SW ];then
    read -p "请输入想要合并的合集目录名：" collection
    do_merge $collection
elif [ "2" == $SW ];then
    for collection in `ls | grep -E ^[0-9]+&`
    # av编号最小是个位数，因此直接匹配纯数字文件夹。
    do
        do_merge $collection
    done
else
    echo "error"
fi

