import { playMode } from 'common/js/config'

// 要传递的变量
const state = {
    singer: {},
    playing: false,            // 是否播放，打开app，默认不播放
    fullScreen: false,         // 是否全屏，默认false
    playList: [],               // 正常顺寻的歌单列表
    sequenceList: [],          // 随机播放的歌单列表
    mode: playMode.sequence,   // 播放模式，例如：随机播放，单曲循环等
    currentIndex: -1
}

export default state